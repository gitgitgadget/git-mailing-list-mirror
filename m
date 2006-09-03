From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Sun, 03 Sep 2006 11:27:36 +0200
Organization: At home
Message-ID: <ede765$b9u$2@sea.gmane.org>
References: <200609021817.09296.jnareb@gmail.com> <edcm1v$24k$1@sea.gmane.org> <e5bfff550609022126j1a79c750vb3aeea01cda10bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 03 11:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJoGd-0005cu-Sr
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 11:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWICJ1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 05:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWICJ1t
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 05:27:49 -0400
Received: from main.gmane.org ([80.91.229.2]:48100 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750935AbWICJ1r (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Sep 2006 05:27:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GJoGX-0005c7-BR
	for git@vger.kernel.org; Sun, 03 Sep 2006 11:27:45 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 11:27:45 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 11:27:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26369>

Marco Costalba wrote:

> On 9/2/06, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> By the way, do the diff between arbitrary revisions (say, between two
>> branches/two refs) and between arbitrary versions of the same file would be
>> useful to have in gitweb?
>>
> 
> A nice tool, lot of ideas to steal ;-)
> 
> http://www.cenqua.com/fisheye/demo/viewrep/ant/src/main/org/apache/tools/ant/?FETOUR=A1

FishEye? I haven't took the full tour, but the tool seems somewhat
CVS centric, i.e. per file history, file description,...

But for example "breadcrumbs" idea for the file path (each segment of path
being link to given (sub)directory) is a nice one. Although if I remember
correctly the pathname (for files only) is currently hack to have somewhere
link to "head" version of current file in plain format.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git



-- 
VGER BF report: U 0.910123
