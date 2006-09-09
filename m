From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Sat, 09 Sep 2006 10:42:41 +0200
Organization: At home
Message-ID: <edtuot$p76$2@sea.gmane.org>
References: <200609061504.40725.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 09 10:45:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLySe-0007kp-GD
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 10:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWIIIpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Sep 2006 04:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWIIIpI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 04:45:08 -0400
Received: from main.gmane.org ([80.91.229.2]:64220 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932375AbWIIIpE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 04:45:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GLySU-0007j7-ET
	for git@vger.kernel.org; Sat, 09 Sep 2006 10:45:02 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 10:45:02 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 10:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26738>

<opublikowany i wys=B3any>

Jakub Narebski wrote:

> Shortlog:
>  [PATCH 1/7] gitweb: Make pickaxe search a feature
>  [PATCH 2/7] gitweb: Paginate history output
>  [PATCH 3/7] gitweb: Use @hist_opts as git-rev-list parameters
>              in git_history
>  [PATCH 4/7] gitweb: Add parse_rev_list for later use
>  [PATCH 5/7] gitweb: Use parse_rev_list in git_shortlog and git_histo=
ry
>  [PATCH 6/7] gitweb: Assume parsed revision list in git_shortlog_body
>              and git_history_body
>  [PATCH 7/7] gitweb: Set page to 0 if it is not defined, in git_histo=
ry

Should I resend corrected patch 1 (Make pickaxe search a feature; but
default to on), and patches 2 and 7 as one patch (Paginate history outp=
ut)?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
