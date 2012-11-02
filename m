From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Fri, 2 Nov 2012 11:20:51 -0400
Message-ID: <20121102152051.GB24622@sigill.intra.peff.net>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
 <20121030044609.GA10873@elie.Belkin>
 <CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
 <20121031012730.GY15167@elie.Belkin>
 <CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
 <20121031021318.GB15167@elie.Belkin>
 <CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
 <509167C8.6090600@kdbg.org>
 <20121102131726.GC2598@sigill.intra.peff.net>
 <CAMP44s2bZa4BnTnSv0Zgdh52Vy613R3cWE3nSxXdR4dDVhJAyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:21:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJ3S-0002e0-TJ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab2KBPUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:20:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54628 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753591Ab2KBPUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:20:54 -0400
Received: (qmail 5696 invoked by uid 107); 2 Nov 2012 15:21:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 11:21:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 11:20:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2bZa4BnTnSv0Zgdh52Vy613R3cWE3nSxXdR4dDVhJAyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208949>

On Fri, Nov 02, 2012 at 04:17:27PM +0100, Felipe Contreras wrote:

> > And me, who is trying to figure out what to do with this patch. It is
> > presented on its own, outside of a series, with only the description "no
> > reason not to do this".
> 
> Yeah, because I think it stands on its own. But I'll include it in the
> remote-hg patch series, I already have it queued up.

Thanks.

-Peff
