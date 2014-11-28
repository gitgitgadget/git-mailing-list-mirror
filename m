From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 15:31:31 +0100
Message-ID: <54788743.5090703@alum.mit.edu>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 15:38:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuMhC-0007xN-C7
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 15:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbaK1Oiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2014 09:38:50 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57078 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846AbaK1Oit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 09:38:49 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Nov 2014 09:38:49 EST
X-AuditID: 12074412-f79e46d0000036b4-ef-547887464128
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EA.9A.14004.64788745; Fri, 28 Nov 2014 09:31:34 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0216.dip0.t-ipconnect.de [93.219.2.22])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sASEVVAI026740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Nov 2014 09:31:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <54776367.1010104@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixO6iqOvWXhFi8GaelkXXlW4mi4beK8wW
	b28uYbT4N6HGYvPmdhaLzo6vjA5sHjtn3WX3WLCp1OPiJWWPz5vkPG4/28YSwBrFbZOUWFIW
	nJmep2+XwJ3Rs+kfe8FluYoZNy4zNjCuluhi5OSQEDCRuLl4FQuELSZx4d56ti5GLg4hgcuM
	Ejum/GEDSQgJnGWSeDDVG8TmFdCWWN24ixnEZhFQlehYuJsJxGYT0JVY1NMMZosKBEmc3HOd
	HaJeUOLkzCdgC0QEsiS+ffrCCmIzC0xklNi8wQDEFhYwlHh0/xzU4mYmic4LPWALOAXUJNrv
	NUI16EnsuP4LypaXaN46m3kCo8AsJDtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy8
	1CJdM73czBK91JTSTYyQUBfawbj+pNwhRgEORiUe3gDGihAh1sSy4srcQ4ySHExKorwnaoBC
	fEn5KZUZicUZ8UWlOanFhxglOJiVRHjTS4ByvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1Kz
	U1MLUotgsjIcHEoSvF5tQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZG
	K0iKB2jvEZB23uKCxFygKETrKUZFKXHeRpCEAEgiozQPbiwsgb1iFAf6UphXCqSKB5j84Lpf
	AQ1mAhosNrUUZHBJIkJKqoFRpj3rw5Tn1T8zZVapTPrTatuWnrh2V/bJlccSWqdPl9B/PEvs
	veM+9+dOe3a/fK5+M2CRSvzTx+WFHzjrsj/w7l3UyZV3fa3YligzxnzXbXVXJ9k/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260364>

On 11/27/2014 06:46 PM, Torsten B=F6gershausen wrote:
> On 2014-11-25 01.28, Michael Haggerty wrote:
> []
>> Let me list the aspects of our mailing list workflow that I find
>> cumbersome as a contributor and reviewer:
>>
>> * Submitting patches to the mailing list is an ordeal of configuring
>> format-patch and send-email and getting everything just right, using
>> instructions that depend on the local environment.
> Typically everything fits into ~/.gitconfig,
> which can be carried around on a USB-Stick.
> Is there any details which I miss, or howtows we can improve ?

I used to need one setup at work and a different one at home (because o=
f
how my email was configured), and sometimes had to switch back and fort=
h
as I carried my notebook around.

>> [...]
>>   * I do "git fetch gitster", then try to figure out whether the bra=
nch
>> I'm interested in is present, what its name is, and whether the vers=
ion
>> in your tree is the latest version, then "git checkout xy/foobar".
> There are 12 branches from mh/, so it should be possible to find the =
name,
> und run git log gitster/xy/fix_this_bug or so.
> Even more important, this branch is the "single point of truth", beca=
use
> this branch may be merged eventually, and nothing else.

I know it's *possible*. The question is whether it could be made easier=
=2E

>> * Following patch series across iterations is also awkward. To compa=
re
>> two versions, I have to first get both patch series into my repo, wh=
ich
>> involves digging through the ML history to find older versions, foll=
owed
>> by the "git am" steps. Often submitters are nice enough to put links=
 to
>> previous versions of their patch series in their cover letters, but =
the
>> links are to a web-based email archive, from which it is even more
>> awkward to grab and apply patches. So in practice I then go back to =
my
>> email client and search my local archive for my copy of the same ema=
il
>> that was referenced in the archive, and apply the patch from there.
>> Finding comments about old versions of a patch series is nearly as m=
uch
>> work.
> In short:
> We can ask every contributor, if the patch send to the mailing list
> is available on a public Git-repo, and what the branch name is,
> like _V2.. Does this makes sense ?

That would be helpful, but it would put yet *another* requirement on th=
e
submitter (to send patch emails *and* push the branch to some accessibl=
e
repository). We regulars could script this pretty easily, but people wh=
o
only contribute occasionally or who are trying to get started will be
even more overwhelmed.

> As an alternative, you can save the branches locally, after running
> git-am once, just keep the branch.
> []

Yes, but it is even more unnecessary manual bookkeeping.

> [...]
> But there is another thing:
> Once a patch is send out, I would ask the sender to wait and collect =
comments
> at least 24 hours before sending a V2.
> We all living in different time zones, so please let the world spin o=
nce.

Yes, good idea.

> My feeling is that a patch > 5 commits should have
> a waiting time > 5 days, otherwise I start reviewing V1, then V2 come=
s,
> then V3 before I am finished with V1. That is not ideal.

One day per patch might be exaggerated, but I agree that long series
should be iterated more slowly than short ones.

> What does it cost to push your branch to a public repo and
> include that information in the email ?

One has to run an additional command and add some information to the
cover letter, every time a patch series is submitted. If it's scripted
then it's relatively painless. But for a newcomer these will be manual
steps that are easy to forget or to do incorrectly, making it more
likely that the newcomer's first contribution to Git will end in mild
embarrassment rather than success.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
