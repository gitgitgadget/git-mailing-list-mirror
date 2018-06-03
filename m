Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B931F403
	for <e@80x24.org>; Sun,  3 Jun 2018 22:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbeFCW2z (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 18:28:55 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:17300 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 18:28:53 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id PbUWfvENUpXFjPbUXfzNYW; Sun, 03 Jun 2018 23:28:52 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=F9j5Uf8UAAAA:8
 a=cTVrTcN_AAAA:8 a=aipVcMkBAAAA:8 a=bAwAFA4xLDdxtNifQWAA:9
 a=XAUl3J4rjG-HH8To:21 a=IzxzgISv7Hnqn48N:21 a=wPNLvfGTeEIA:10
 a=-FEs8UIgK8oA:10 a=MY9urf3tlLUA:10 a=NWVoK91CQyQA:10
 a=tXc6gU1OR7GYS4cjKmeK:22 a=52NZFvr88-HOQ7-uGVbO:22 a=PL7z1zrK7_SH3APU-pza:22
Message-ID: <5F80881E35F941E88D9C84565C437607@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com> <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
Subject: Re: GDPR compliance best practices?
Date:   Sun, 3 Jun 2018 23:28:43 +0100
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
X-Antivirus: AVG (VPS 180603-4, 03/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBtPtdS106Mb/hp+lmxupd2yeeFLQoY0BspJfK3ZGAS1jKOLBXM9wJuQPsVO0dIkRv98zWKUCJbNQVID5J4YLzkUuylHjNYldGtDDL2qk7vrQgr7p+KM
 JEMF9b+OZ/M9915BWG5+NPyvY7TddhEMli2SOdtJjiE1mTHSY4sG+DQbL1gl/6Ai+XLj/WVAow+2wG2ojWVL47Bc83BcRj4/lHEysyJzwTZBtgr4f8v0HqiU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Peter Backes" <rtc@helen.PLASMA.Xg8.DE>
> On Sun, Jun 03, 2018 at 04:28:31PM +0100, Philip Oakley wrote:
>> In most Git cases that legal/legitimate purpose is the copyright licence,
>> and/or corporate employment. That is, Jane wrote it, hence X has a legal
>> rights of use, and we need to have a record of that (Jane wrote it) as
>> evidence of that (I'm X, I can use it) right. That would mean that Jane
>> cannot just ask to have that record removed and expect it to be removed.
>
> Re corporate employment:
>
> For sure nobody would dare to quesion that a company has a right to
> keep an internal record that Jane wrote it.
>
> The issue is publishing that information. This is an entirely different
> story.

It is here that Article 6 kicks in as to whether the 'organisation' can 
retain the data and continue to use it.
https://gdpr-info.eu/art-6-gdpr/
https://ico.org.uk/for-organisations/guide-to-the-general-data-protection-regulation-gdpr/lawful-basis-for-processing/
https://www.lawscot.org.uk/news-and-events/news/gdpr-legal-basis-and-why-it-matters/

For an open source project with an open source licence then an implict DCO 
applies for the meta data. It is the legal  basis for the the release.

If a corporate project has a closed source project, then yes, open 
publishing of that personal data within a repo's meta data would be 
incorrect, even though the internal repo would be kept.


>
> I already stressed that from the very beginning.
>
> Re copyright license:
>
> No, a copyright license does not provide a legitimization.
>
> - copyright is about distributing the program, not about distributing
> version control metadata.

It is specificaly about giving that right to copy by Jane Doe (but git gives 
no other information other than that supposedly globally unique 'author 
email'.

>
> - Being named is a right, not an obligation of the author. Hence, if
> the author doesn't want his name published, the company doesn't have
> legitimate grounds based in copyright for doing it anyway, against his
> or her will.

Git for Open Source is about open licencing by name. I'd agree that a closed 
corporate licence stays closed, but not forgotten.

>
>> From a personal view, many folk want it to be that corporates (and open
>> source organisations) should hold no personal information with having
>> explicit permission that can then be withdrawn, with deletion to follow.
>> However that 'legal' clause does [generally] win.
>
> Let's be honest: We do not know what legitimization exactly in each
> specific case the git metadata is being distributed under.

We should know, already. A specific licence [or limit] should be in place. 
We don't really want to have to let a court decide ;-)

>
> It may be copyright, it may be employment, but it may also be revocable
> consent. This is, we cannot safely assume that no git user will ever
> have to deal with a legitimate request based on the right to be
> forgotten.
>

The law is never decided by technical means, unfortunately. Regular git 
users should have no issues - they just need to point their finger at the 
responsible authority. (beware though, of the oneway trap door that the 
users mistakes can become the problem for the responsible authority!)


>> In the git.git case (and linux.git) there is the DCO (to back up the 
>> GLP2)
>> as an explicit requirement/certification that puts the information into 
>> the
>> legal evidence category. IIUC almost all copyright ends up with a similar
>> evidentail trail for the meta data.
>
> This makes things more complicated, not less. You have yet more meta
> data to cope with, yet more opportunities to be bitten by the right to
> be forgotten. Since I proposed a list of metadata where each entry can
> be anonymized independently of each other, it would be able to deal
> with this perfectly.

The DCO/GPL2 are the legitimate data record that recipients should have for 
their copy. There is no right to be forgotten at that point.

>
>> The more likely problem is if the content of the repo, rather than the 
>> meta
>> data, is subject to GDPR, and that could easily ruin any storage method.
>> Being able to mark an object as <Lost/Deleted> would help here(*).
>
> My proposal supports any part of the commit, including the contents of
> individual files, as eraseable, yet verifiable data.
>
>> Also remember that most EU legislation is 'intent' based, rather than
>> 'letter of', for the style of legal arguments (which is where some of the 
>> UK
>> Brexit misunderstandings come from), so it is more than possible to get 
>> into
>> the situation where an action is both mandated and illegal at the same 
>> time,
>> so plent of snake oil salesman continue to sell magic fixes according to 
>> the
>> customers local biases.
>
> This may be true. I am not trying to sell snake oil, however. To have
> erasure and verifiability at the same time is a highly generic feature
> that may be desirable to have for a multitude of reasons, including but
> not limited to legal ones like GDPR and copyright violations.
>
>> I do not believe Git has anything to worry about that wasn't already an
>> issue.
>
> Yes, but it definitely had and still does have something to worry about.
>
> git should provide technical means to deal with this. I provided a
> proposal based on anonymization that does not in any way have any
> drawback compared to the status quo, except a slight increase in
> metadata size and various degrees of backwards incompatibility,
> depending on how it is implemented.
>
> What do you think about my proposal as a solution for the problem?

I see the solution to be elsewhere, and that it is in some ways a strawman 
discussion: "if someone has the right to be forgotten, how do we delete the 
meta data", when that right (to delete the meta data in a properly licence 
repo) does not exist.

That said, the problem of maintaining repo integrity when some objects must 
be deleted or re-written (because they had stored peronal info that they 
should not have), will require a little bit extra on the side.

But this is open source, so ideas, and code, will come forward that allows 
things like 'replaced commits' to be formally part of a repo and its leading 
oid (or maybe it's an oid pair) will handle that. I'd guess that the commit 
will have an extra line after the parents and tree lines that details (in 
some manner) the 'replaced' things, so that fsck still works, the oid is 
complete and thus the whole shebang can be verified.

>
> You provide a lot of arguments about why it is not a necessity to have
> this, but let's assume it is; is there any actual problem you see with
> the proposal, except that someone would have to implement it?

It's the strawman problem. If it was a real 'real issue' then it would have 
already shown up with companies clamouring to pay folk to fix our (git's) 
latest problem. But the haven't, so I think it's a much more balanced issue.
--
Philip



