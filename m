From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6 (v2)] Suggested for PU: revision caching system to 
 significantly speed up packing/walking
Date: Mon, 17 Aug 2009 10:16:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171012210.4991@intel-tinevez-2-302>
References: <op.uyb1uryftdk399@sirnot.private>  <c77435a80908161547x4d2a9087qf439d1c30cc4fa99@mail.gmail.com>  <4A889412.9090209@vilain.net> <c77435a80908161756n88eb967wbc82058fc4975c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:16:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxOg-0004pB-Td
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350AbZHQIQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757229AbZHQIQo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:16:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:39845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757189AbZHQIQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:16:43 -0400
Received: (qmail invoked by alias); 17 Aug 2009 08:16:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 17 Aug 2009 10:16:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VRk5pBmfVQs4y4dB8SXC/pBq2FHGnq1/8BVz4r5
	17VWsRORncad+b
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <c77435a80908161756n88eb967wbc82058fc4975c04@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126138>

Hi,

On Mon, 17 Aug 2009, Nick Edelen wrote:

> If I'm being confusing I can just upload them to v3, but I didn't want 
> to bombard everyone with duplicates.

I think by now people _are_ confused, so it's probably better to "bomb" 
everyone with a clean current version of your patch series.

Although I have to admit that I am scared away by the sheer size of the 
individual patches (together with bad feelings from earlier discussions 
that I want to avoid).

Ciao,
Dscho
