From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 10:58:07 +0100
Message-ID: <508E532F.2010109@alum.mit.edu>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com> <508D7628.10509@kdbg.org> <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com> <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley> <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com> <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 10:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSm6z-0002WU-MG
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 10:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288Ab2J2J6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 05:58:13 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:58764 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758019Ab2J2J6M (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 05:58:12 -0400
X-AuditID: 1207440e-b7f036d0000008b5-14-508e5333bb58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.3A.02229.3335E805; Mon, 29 Oct 2012 05:58:11 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9T9w86X012576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Oct 2012 05:58:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqGsc3Bdg8G+bicXBOyfZLHbO3cdq
	0XWlm8niydy7zBadU2UdWD12zrrL7rF86TpGj4evutg9dp9m9fi8SS6ANYrbJimxpCw4Mz1P
	3y6BO+PCrWNMBSfYK6Z/WsjUwNjL1sXIySEhYCLRvmI+E4QtJnHh3nqgOBeHkMBlRonePY8Y
	IZzjTBKfVu8Cq+IV0JY4fG0pkM3BwSKgKtGwIh8kzCagK7GopxmsRFQgTGL5zs1Q5YISJ2c+
	YQGxRQT0JR4+6WcGmcks0Mso8evqHWaQOcICUhL79vOB1AgJvGSSuPI3HMTmFAiUOLL5FCuI
	zSygI/Gu7wEzhC0vsf3tHOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/Py
	Uot0jfVyM0v0UlNKNzFCApxvB2P7eplDjAIcjEo8vE1vegOEWBPLiitzDzFKcjApifLO8O8L
	EOJLyk+pzEgszogvKs1JLT7EKMHBrCTCu5QbqJw3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEk
	NTs1tSC1CCarwcEhsGbd6guMUix5+XmpShK8ukFACwSLUtNTK9Iyc0oQSpk4OEEWcUmJFKfm
	paQWJZaWZMSDIji+GBjDICkeoBuEQdp5iwsSc4GiEK2nGHU5PjbOe8goBLZDSpyXA6RIAKQo
	ozQPbgUszb1iFAf6XphXAqSKB5gi4Sa9AlrCBLREhw/k0eKSRISUVAMjo9mKlgbW93FuG6vn
	XPywKFdw33RZRmF/Hm0d4/NBAgZz5/tc/fo+5rptmoaml/zpuXuit8eW/74bu8Ku 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208608>

I agree with you that it is too easy to create chaos by changing tags in
a published repository and that git should do more to prevent this from
happening without explicit user forcing.  The fact that git internally
handles tags similarly to other references is IMO an excuse for the
current behavior, but not a justification.

On 10/29/2012 09:12 AM, Angelo Borsotti wrote:
> to let the owner of a remote repository (one on which git-push
> deposits objects) disallow
> others to change tags, a key on its config file could be used.
> An option on git-push, or environment variable, or key in config file
> of the repo from which git-push takes objects do not help in enforcing
> the policy not to update tags in the remote repo.

If your remote repository is managed using gitolite, you can institute
restrictions on changing tags via the gitolite config.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
