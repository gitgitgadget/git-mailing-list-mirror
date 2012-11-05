From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lack of netiquette, was Re: [PATCH v4 00/13] New remote-hg helper
Date: Mon, 05 Nov 2012 17:00:16 +0100
Message-ID: <5097E290.4030700@drmicha.warpmail.net>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net> <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info> <CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com> <20121031185903.GA1480@elie.Belkin> <CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com> <alpine.DEB.1.00.1210312126080.7256@s15462909.onlinehome-server.info> <bec4d263-b458-4636-9fa6-1c1202416810@email.android.com> <CAMP44s2G2MGuPH-UXfoKNOpx0cuSE87Uz=6B-7H1MzJHf6VMjA@mail.gmail.com> <50927D29.3020703@lsrfire.ath.cx> <5093949D.4070509@op5.se> <5093A873.9090701@drmicha.warpmail.net> <CAMP44s0yk3k1awYbJCcRe
 BDEAjMyfHtKH70S7v2ZOJ1u5OcBAw@mail.gmail.com> <5097860E.5040607@drmicha.warpmail.net> <CAMP44s3i1M9YtQb-EG+LS8DbwX10q2xE-LdxZCy3Xa_x3tQ9kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:00:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP6K-0001T3-EY
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 17:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab2KEQAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 11:00:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47413 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab2KEQAT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 11:00:19 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 91A6A20665;
	Mon,  5 Nov 2012 11:00:18 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 05 Nov 2012 11:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nyf6UnyBcBpfy10zKNFSh1
	SdJGY=; b=FAObmq24evZLpZI1ffPfI5HtP4b6lH61mDrjrAXY3w6+Hu6VyywBVY
	JxYwi8e9QaKMT0+bEE17kOwP/Cdi4/CRPAAEak8f1ncskXFyJDHQnbSD2eE7jcv6
	5+wJlXItl0J8/9hEwMHbco5qcFtZG1MGGTTCSgqI/BE6/4WZFRnQ8=
X-Sasl-enc: zze3esOfQIkqERIFLLw8Zyzq2DQIG61vncgCdMMJ7gh0 1352131218
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 33EF68E04E0;
	Mon,  5 Nov 2012 11:00:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s3i1M9YtQb-EG+LS8DbwX10q2xE-LdxZCy3Xa_x3tQ9kA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209073>

[trimmed down heavily by mjg]
Felipe Contreras venit, vidit, dixit 05.11.2012 16:22:
> On Mon, Nov 5, 2012 at 10:25 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 02.11.2012 17:09:
>>> On Fri, Nov 2, 2012 at 12:03 PM, Michael J Gruber
>>> <git@drmicha.warpmail.net> wrote:

> There is no lack of openness from my part. I hear all technical
> arguments, and I reply on a technical basis. The problem seems to be
> is that you expect the code submitted to be criticized, but not the
> criticism it receives. IOW; the submitter has to put up with anything
> anybody says about his/her code and ideas, but the *reviewer* is
> untouchable; the submitter cannot ever criticize the reviewer. I can

Feel free to criticize the criticism, just don't offend the criticizer
(be it the reviewer or the submitter).

> tell you that doesn't happen in the Linux kernel; the review process
> is a _discussion_, not a one-way communication, and discussions can be
> heated up, but the end result is better code, *both* sides are open to
> criticism, the submitter, *and* the reviewer.

Exactly, both.

>> And no, using the same or similar language does not make us the same at
>> all. Using the same language is the natural prerequisite for successful
>> communication.
> 
> Nobody said otherwise.

Well, you did in the post I responded to:

>>> The dangers of "everyone" following the same style of communication,
>>> and making "everyone" feel comfortable, is that "everyone" ends up
>>> being the same kind of people

In any case, I feel I've showed enough efforts and there's no point in
dragging this on.

Michael
