From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Tue, 6 May 2008 09:55:58 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805060954470.30431@racer>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>  <1209815828-6548-5-git-send-email-pkufranky@gmail.com>  <7vy76rtfns.fsf@gitster.siamese.dyndns.org>  <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com> 
 <alpine.DEB.1.00.0805041040560.30431@racer>  <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>  <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>  <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>  <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
  <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 10:57:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtIzL-0000Sk-9J
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 10:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763075AbYEFI4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 04:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762732AbYEFI4F
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 04:56:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:46920 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763544AbYEFI4B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 04:56:01 -0400
Received: (qmail invoked by alias); 06 May 2008 08:55:59 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp003) with SMTP; 06 May 2008 10:55:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+q2g4yoI+8/36WH3vf8UQqkfaKVsbiTW921vbAD
	uc1plOdCpTOUNa
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81346>

Hi,

On Tue, 6 May 2008, Ping Yin wrote:

> On Mon, May 5, 2008 at 8:10 PM, Ping Yin <pkufranky@gmail.com> wrote:
> 
> I will come up with an implementation still using diff.nonwordchars few 
> days later.

If I did not like the unnecessary negative approach "nonwordchars" (as 
opposed to "wordchars"), it seems even less appropriate now, when you 
actually want to discern between "spaceCharacters", 
"punctuationCharacters" and "wordCharacters".

Hth,
Dscho
