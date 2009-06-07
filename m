From: Sam Vilain <sam@vilain.net>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to
 pack-objects
Date: Mon, 08 Jun 2009 08:48:33 +1200
Message-ID: <1244407713.5870.7.camel@maia.lan>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
	 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
	 <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
	 <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDPHO-00031z-15
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbZFGUrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755104AbZFGUrf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:47:35 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35563 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbZFGUrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:47:35 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 20BE321CCEB; Mon,  8 Jun 2009 08:47:29 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.182] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id C7D9F21C48F;
	Mon,  8 Jun 2009 08:47:24 +1200 (NZST)
In-Reply-To: <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121002>

On Sun, 2009-06-07 at 20:55 +0200, Nick Edelen wrote:
> how does this look?
> 
> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> 
> ---

Comments like that belong after the '---'; the change description is
part of the work that you are developing, too.

Sam.
