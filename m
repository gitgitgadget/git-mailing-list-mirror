From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 19:53:32 +0200
Message-ID: <87wqq39nmr.fsf@hexa.v.cablecom.net>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljoO-0004LW-LW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab3FIRxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:53:36 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:7557 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab3FIRxf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:53:35 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:53:27 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 19:53:32 +0200
In-Reply-To: <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 9 Jun 2013 07:15:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227053>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 9, 2013 at 12:26 AM, Jeff King <peff@peff.net> wrote:
>> On Sat, Jun 08, 2013 at 09:17:56PM -0500, Felipe Contreras wrote:
>>
>>> > Definitely, yes.  Even if you look at the impact on code alone and
>>> > don't care about the people, destroying a collegial work environment
>>> > is harmful enough to the code to outweigh the (admittedly often
>>> > useful) patches.
>>>
>>> A collegial work environment is overrated, and proof of that the Linux
>>> kernel, where honest and straight talk is the bread and butter of the
>>> mailing list. And the Linux kernel is the most successful software
>>> project in history by far. It's code that speaks.
>>
>> Sorry, but I don't agree, and I want to publicly state my opinion so
>> that Jonathan (and other bystanders on the list) knows that he is not
>> alone in his opinions.

FWIW, I'll add my voice here.

In addition to what has been said by Jeff and Jonathan already (and with
which I agree), I would like to point out one observation about your
style of discussion that I find particularly unproductive.

You have a tendency, when facing arguments by someone who does not agree
with you, of picking out one (usually minor) point of their statement
and attacking just *that* on grounds that are usually much harder to
argue, without regard for the bigger issue.  In effect you are
attempting to shift a significant burden of proof back to the other
party.

Case in point:

>> I have consistently found your demeanor on the list to be very
>> unfriendly and difficult to work with. It is one thing to have honest
>> and straight talk, and another thing to be obstinate, unmindful of
>> feedback (both with respect to technical details, as well as to
>> communication styles), and disrespectful of other people.
>
> Go back to my 261 commits, show me one that is "unmindful of technical details".

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
