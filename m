From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Fri, 31 May 2013 06:16:45 +0000 (UTC)
Message-ID: <loom.20130531T081035-747@post.gmane.org>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:17:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiIel-000266-Js
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab3EaGRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 02:17:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:46029 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab3EaGRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:17:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UiIe7-0001oB-94
	for git@vger.kernel.org; Fri, 31 May 2013 08:17:35 +0200
Received: from 195.204.181.130 ([195.204.181.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 May 2013 08:17:03 +0200
Received: from oystwa by 195.204.181.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 May 2013 08:17:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.204.181.130 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:20.0) Gecko/20100101 Firefox/20.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226048>

Junio C Hamano <gitster <at> pobox.com> writes:

> * kb/status-ignored-optim-2 (2013-05-29) 1 commit
>  - dir.c: fix ignore processing within not-ignored directories
>=20
>  Fix 1.8.3 regressions in the .gitignore path exclusion logic.

Hi,

I see that the Tested-by line in kb/status-ignored-optim-2 (3973cbd)
doesn't contain my e-mail address. I personally have no particular
preference whether it's there or not, but I noticed that it usually is
on Tested-by lines, so I'm wondering if I have slipped on some standard
practice. Would be useful to know in case I get the chance to help out
more :)

Thanks,
=C3=98sse
