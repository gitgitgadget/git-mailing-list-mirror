Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EBE1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 12:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeFDMYS (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 08:24:18 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:26494 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeFDMYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 08:24:16 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id PoWxfvxzrpXFjPoX0fzWIe; Mon, 04 Jun 2018 13:24:15 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=AxXAyR1qQXCIpV27TrgA:9
 a=_COVsI09wkmKwHoe:21 a=CbTa6DYHQ12wNR-o:21 a=wPNLvfGTeEIA:10
 a=MY9urf3tlLUA:10
Message-ID: <31E7614B606B48909B9E850E62926979@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <5F80881E35F941E88D9C84565C437607@PhilipOakley> <20180603230138.GA14956@helen.PLASMA.Xg8.DE>
Subject: Re: GDPR compliance best practices?
Date:   Mon, 4 Jun 2018 13:24:04 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180604-0, 04/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfNuJL39SPuC+TqpIAVffbFFWfqW8LRg54Ogn/RDeHb1kymBqvzAlbcl5gdLDCw4K4+baVxCgci7Ko826pXBu1T466RtuIt9E3UePWpuSsW9xeu/Bz2RY
 qeBA4p7ljx51vzkQoT2rvB6OQ4Y0oIpqhfL4BTFwz3rrV1Alik/tR5zKZOB2kiSo2VMJkWCjFWz91Vp5Z0kIQB3r3ylZkaPmRnf1GsuNJiezCJfzozDYHA3k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,
(lost the cc's)

From: "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
> On Sun, Jun 03, 2018 at 11:28:43PM +0100, Philip Oakley wrote:
>> It is here that Article 6 kicks in as to whether the 'organisation' can
>> retain the data and continue to use it.
>
> Article 6 is not about continuing to use data. Article 6 is about
> having and even obtaining it in the first place.

Correct, and that is the part I was refering to. Recipients of the
particular meta data require it for the licencing purpose. Thus they can
continue to have (and 'need') that data. It is that 'other side of the 
fence'
view I mentioned.

>
> Article 17 and article 21 are about continuing to use data.
>
>> For an open source project with an open source licence then an implict
>> DCO
>> applies for the meta data. It is the legal  basis for the the release.
>
> Neither article 6 nor 17 or 21 have anything remotely like an "implicit
> DCO" as a legitimization for publishing employee data.

I was refering to 'implict' in a reverse direction, that is, the DCO
supports the legal basis to have and hold the data. The express licence
terms in the various open source licences give the permission, and becomes
one of these legally conflicting aspects

>
> The GDPR is very explicit about implicit stuff never being a basis for
> consent, if you want to imply that is your basis. And consent can be
> withdrawn at any time anyway.
>
> An open source license has nothing whatsoever to do with the question
> of version control metadata. A public version control system is not
> necessary to publish open source software.
>
>> > - copyright is about distributing the program, not about distributing
>> > version control metadata.
>> It is specificaly about giving that right to copy by Jane Doe (but git
>> gives
>> no other information other than that supposedly globally unique 'author
>> email'.
>
> I don't get what you are saying. As I said, a public version control
> system is not necessary to publish open source software. The two things
> may be intimately related in practice, but not in theory.

Such is the law. It's the practice that is legal/illegal, decided in court
(if it gets there)

>
>> > - Being named is a right, not an obligation of the author. Hence, if
>> > the author doesn't want his name published, the company doesn't have
>> > legitimate grounds based in copyright for doing it anyway, against his
>> > or her will.
>> Git for Open Source is about open licencing by name. I'd agree that a
>> closed
>> corporate licence stays closed, but not forgotten.
>
> Again I don't get what you are saying. The author has a right to be
> named as the author, not an obligation. This has nothing whatsoever to
> do with the question of Open Source vs. closed corporate licenses.
>

The question is which clause is being used to justify an action. Those
corporate organisations want a legal basis for holding data, not a voluntary
permisson (because folk may try and rescind that permission... ). Those in
open source want to ensure that their licence is a legal basis for other
folk to have copies, and that folk can show they have that permission.

Those with a personal data view, will focus on the hope that they can remove
permission, especially for companies that are doing things they find
unacceptable, and maybe 'illegal' or unethical. The GDPR attempts to balance
the different set of expectaions, and the overlaps will need to be
negotiated. Different nations (and individuals) have different perceptions
as to what is normal and reasonable thus focus on different aspects, not
appreciating the Competeing Values that are present in the different
Frameworks of their weltanshauung.

If a closed source corporate does publish their closed data, they have real
internal problems anyway regarding that contradiction!

>> > Let's be honest: We do not know what legitimization exactly in each
>> > specific case the git metadata is being distributed under.
>>
>> We should know, already. A specific licence [or limit] should be in
>> place.
>> We don't really want to have to let a court decide ;-)
>
> It is insufficient to have a license for distributing the program. The
> license is not a GDPR legitimization for git metadata. Distributing the
> program can be done without distributing the author's identity as part
> of the metadata of his commits.
>
>> The law is never decided by technical means, unfortunately.
>
> It is. The GDPR refers to the state of the art of technology without
> defining it. Thus, technical means are very important in the GDPR. This
> may be something new for lawyers. If technology changes tomorrow, even
> without anything else changing, you may be breaking the GDPR by this
> simple fact tomorrow, while not breaking it today.
>

They will still argue about what is the state of the art, and that if the
art is hidden in some lab, then it's not available to meet the criteia.

> Again: Technology is very important in the GDPR.

We know quantum computing can crack the codes, but.... when does it become
the state of the art. SHA1 has been 'cracked' once in one special case, but
that doesn't make it state of the art for cracking a Git repo. It is a
problem about fooling some of the people some of the time which needs to
become [not fooling] most of the [appropriate] people most of the time. That
is what the owners should have known.

Some of this is, unfortunately, also about legal systems as to their
approaches to law and evidence, so UK maybe responding differently to
Germany, or USA, as to what even the words mean.

>
>> Regular git users should have no issues - they just need to point
>> their finger at the responsible authority.
>
> If git users are putting commits online for global download, they are
> the responsible authority.
>
>> The DCO/GPL2 are the legitimate data record that recipients should have
>> for
>> their copy. There is no right to be forgotten at that point.
>
> What do you mean by "should have for their copy"? Why shouldn't there
> be a right to be forgotten?

It isn't an absolute GDPR right

>           Open Source Software has been distributed a
> lot without detailed version control history information. Having this
> information as a record is certainly in the interest of the recipient,
> but it is very very questionable that it is an overriding legitimate
> grounds as per Art. 17 for keeping that data.

So your agument is that you/someone can make someone else guilty of an
offence by demanding they destroy evidence that proves their innocence.
>
>> I see the solution to be elsewhere, and that it is in some ways a
>> strawman
>> discussion: "if someone has the right to be forgotten, how do we delete
>> the
>> meta data", when that right (to delete the meta data in a properly
>> licence
>> repo) does not exist.
>
> See, this kind of shady legal argument is what lawyers are selling you.
> Why not put the energy into designing a technical solution.
>
> They tell you: "Ignore the GDPR. I will give you backup by giving you
> lots of disclaimers and excuses for doing so. Just give me a lot of
> money."

It's: make sure you understand all sides of the GDPR. There is a lot of FUD
from all sides.

>
> Having the ability to validate yet erase data form repositorys is
> desirable from a technical point of view. It has a lot of uses, not
> necessarily only legal ones. The objection of efficiency raised by Ted
> is a valid one. The strawman argument is not.

Efficiency would not be a valid argument. A major annoyance, yes. Something
that likely would stop open source contributers working on it, yes. But just
as ALARP is used in safety to say spend what it takes, if slowing down the
processing is what it takes to meet the GDPR then do it, so companies (and 
those
that do the processing) would have to fund that.

Thanks

Philip

