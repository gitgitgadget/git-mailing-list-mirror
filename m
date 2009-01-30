From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git mergetool from next not working in subdirectory
Date: Fri, 30 Jan 2009 13:50:46 +0000 (UTC)
Message-ID: <glv0jl$cbl$1@ger.gmane.org>
References: <glutv9$4b1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LStnE-00012o-Nw
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZA3Nu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 08:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbZA3Nu4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:50:56 -0500
Received: from main.gmane.org ([80.91.229.2]:45917 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225AbZA3Nu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:50:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LStlm-0004M0-RV
	for git@vger.kernel.org; Fri, 30 Jan 2009 13:50:54 +0000
Received: from u-4-203.vpn.rwth-aachen.de ([137.226.100.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:50:54 +0000
Received: from heipei by u-4-203.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 13:50:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-203.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107819>

On 2009-01-30, Jonas Flod=E9n <jonas.floden@gmail.com> wrote:
> I just upgraded to the current 'next' version of git
> ...
> This works perfectly fine with the 'master' version (1.6.1.2-253-ga34=
a).

Hi,

as you're running next you seem to be interested in the git development=
=2E=20
That's why I suggest you try to bisect the commit that causes this.=20
=46ixing it is another problem entirely, but this way you'd at least ta=
ke=20
the tedious of work of a. duplicating your setup b. finding the bug off=
=20
of the git developers.

Greetings,
Jojo

--=20
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
