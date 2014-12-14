From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [wish] Revert changes in git gui
Date: Sun, 14 Dec 2014 18:53:14 -0000
Organization: OPDS
Message-ID: <CEA0701CFAE141D0BD40149A8D1BC1B4@PhilipOakley>
References: <54875263.1010407@grueninger.de>	<548759C2.5030909@kdbg.org>	<CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>	<548AA6E6.5050805@grueninger.de> <CAKPyHN2sur9KHVkLGq2WPzvc5hLD8BfK-hA7EyZ=-3DTZRTRQA@mail.gmail.com> <548DD626.5060102@grueninger.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Christoph_Gr=FCninger?= <foss@grueninger.de>,
	"Bert Wesarg" <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 19:52:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0EHE-0007gd-0F
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 19:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbaLNSwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 13:52:16 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:3955 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbaLNSwO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Dec 2014 13:52:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvIYAHbbjVROl3AWPGdsb2JhbABagwZSWIccvj+FbAQCgRAXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAwgBASgBBR4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBA4gcCcE6jxIgj3KDHYETBYUNiHVMgnKGPDCMRIM4hA4+MAGCQgEBAQ
X-IPAS-Result: AvIYAHbbjVROl3AWPGdsb2JhbABagwZSWIccvj+FbAQCgRAXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAwgBASgBBR4BASELAgMFAgEDFQMJJRQBBBoGBwMUBgESCAIBAgMBA4gcCcE6jxIgj3KDHYETBYUNiHVMgnKGPDCMRIM4hA4+MAGCQgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,576,1413241200"; 
   d="scan'208";a="768244698"
Received: from host-78-151-112-22.as13285.net (HELO PhilipOakley) ([78.151.112.22])
  by out1.ip01ir2.opaltelecom.net with SMTP; 14 Dec 2014 18:52:12 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261402>

=46rom: "Christoph Gr=FCninger" <foss@grueninger.de>
> Hi Bert,
> yes and no. I couldn't find a message from you requesting a merge of
> this patch. Maybe it's me, I am not familiar with the way it works fo=
r
> Git.
>
> @Git developers: Do you consider merging Bert's patch? If not, what's
> the reason?
>
> Bye
> Christoph
>
>
> On 12.12.2014 at 10:28, Bert Wesarg wrote:
>> On Fri, Dec 12, 2014 at 9:27 AM, Christoph Gr=FCninger
>> <foss@grueninger.de> wrote:
>>> Hi Bert,
>>> your commit is more than half a year old. Do you intent to include
>>> that
>>> into Git master? If not, what's the reason?
>>
>> Thats a really odd question to a person who posted this patch to the
>> mailling list the fist place, isn't it? If anything you should have
>> asked the git gui developers and community, why they didn't show
>> interest to have this in master, right?
>>
Hi,
Git gui isn't maintained by Junio himself :
http://git-blame.blogspot.co.uk/2011/04/note-from-maintainer.html
<quote>
Although the following are included in git.git repository, they have
their own authoritative repository and maintainers:

  a.. git-gui/ comes from git-gui project, maintained by Pat Thoyts:

git://repo.or.cz/git-gui.git
</quote>

Perhaps copy the original patch to Pat, with the justifications, review=
s=20
and Acks, to see if it's acceptable.
--
Philip
