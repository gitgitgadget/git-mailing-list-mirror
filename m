From: Fraser Tweedale <frase@frase.id.au>
Subject: Re: [PATCH] diff-options: document default similarity index
Date: Fri, 5 Jul 2013 20:00:13 +1000
Message-ID: <20130705100012.GR2457@bacardi.hollandpark.frase.id.au>
References: <1373013737-2448-1-git-send-email-frase@frase.id.au>
 <7vbo6h8jpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 12:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv2oV-0006IA-2C
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 12:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757076Ab3GEKAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 06:00:23 -0400
Received: from 110-174-235-130.static.tpgi.com.au ([110.174.235.130]:60473
	"EHLO bacardi.hollandpark.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757048Ab3GEKAW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 06:00:22 -0400
Received: from bacardi.hollandpark.frase.id.au (localhost [127.0.0.1])
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5) with ESMTP id r65A0Dia004417;
	Fri, 5 Jul 2013 20:00:13 +1000 (EST)
	(envelope-from frase@frase.id.au)
Received: (from fraser@localhost)
	by bacardi.hollandpark.frase.id.au (8.14.5/8.14.5/Submit) id r65A0DZ8004416;
	Fri, 5 Jul 2013 20:00:13 +1000 (EST)
	(envelope-from frase@frase.id.au)
X-Authentication-Warning: bacardi.hollandpark.frase.id.au: fraser set sender to frase@frase.id.au using -f
Content-Disposition: inline
In-Reply-To: <7vbo6h8jpj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229646>

On Fri, Jul 05, 2013 at 02:00:40AM -0700, Junio C Hamano wrote:
> Fraser Tweedale <frase@frase.id.au> writes:
> 
> > The default similarity index of 50% is documented in gitdiffcore(7)
> > but it is worth also mentioning it in the description of the
> > -M/--find-renames option.
> 
> Is it?  I am not sure if it is worth it.

The -M description goes on at some length to explain how to specify
a particular value.  Surely a brief mention of the default value is
also warranted, especially since the pointer to gitdiffcore(7) for a
more detailed explanation of the options appears quite a way below.
