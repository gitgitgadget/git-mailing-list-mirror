From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] shell: allow 'no-interactive-login' command to
 disable interactive shell
Date: Tue, 12 Mar 2013 06:47:25 -0400
Message-ID: <20130312104725.GB11340@sigill.intra.peff.net>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130309215237.GA24777@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 11:47:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFMkP-00022c-L5
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 11:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab3CLKrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 06:47:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932497Ab3CLKr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 06:47:29 -0400
Received: (qmail 25837 invoked by uid 107); 12 Mar 2013 10:49:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 06:49:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 06:47:25 -0400
Content-Disposition: inline
In-Reply-To: <20130309215237.GA24777@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217943>

On Sat, Mar 09, 2013 at 01:52:37PM -0800, Jonathan Nieder wrote:

> Here's a reroll along the lines described at
> http://thread.gmane.org/gmane.comp.version-control.git/216229
> 
> As before, this series is meant to give users of basic 'git shell'
> setups a chance to imitate some nice behaviors that GitHub and
> gitolite offer in more complicated ways.  Thanks for your help on it
> so far.

Thanks, this version looks good to me.

-Peff
