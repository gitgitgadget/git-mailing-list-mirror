From: Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Tue, 11 Jun 2013 11:18:07 +0200
Message-ID: <20130611091807.GA11361@alap2.anarazel.de>
References: <20130608164902.GA3109@elie.Belkin>
 <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin>
 <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
 <20130609014049.GA10375@google.com>
 <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
 <20130609052624.GB561@sigill.intra.peff.net>
 <CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
 <20130609174049.GA1039@sigill.intra.peff.net>
 <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 11:24:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmKoa-0001qK-7d
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 11:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab3FKJY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 05:24:28 -0400
Received: from mail.anarazel.de ([217.115.131.40]:39284 "EHLO mail.anarazel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab3FKJY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 05:24:27 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2013 05:24:27 EDT
Received: from intern.anarazel.de (p5DDC7BD8.dip0.t-ipconnect.de [93.220.123.216])
	(Authenticated sender: andres@anarazel.de)
	by mail.anarazel.de (Postfix) with ESMTPSA id 35C1B4E8001;
	Tue, 11 Jun 2013 11:18:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227425>

On 2013-06-09 13:01:30 -0500, Felipe Contreras wrote:
> >> You don't agree that 1) a collegial work environment is overrated, 2)
> >> that the Linux kernel doesn't put an emphasis on being collegial, or
> >> 3) that it's the most successful software project in history?
> >
> > Point 1.
> 
> Good, so we agree that a project doesn't need a collegial work
> environment to be extremely and amazingly successful. In fact, any
> rational person would keep an open mind to the fact that perhaps it
> actually _helps_ to not have such environment, based on the evidence.

Just from skimming both lists, most of the time I find lkml to be nicer
(and more collegial) to read because it has a better atmosphere than
git@ had in the last year or two.

And yes, a good atmosphere plays an important role. One of the reasons
is that it makes it easier to discern arguments based on personality
disputes - which certainly exist on lk - from actual technical
disagreements that need to be resolved.

Greetings,

Andres Freund
