From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Tue, 16 Oct 2007 22:24:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710162223030.19446@xanadu.home>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <20071017021137.GO13801@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihyac-0008EI-Gp
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760248AbXJQCY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761601AbXJQCY2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:24:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41747 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532AbXJQCY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:24:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ1003T1AOPLG01@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 22:24:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071017021137.GO13801@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61317>

On Tue, 16 Oct 2007, Shawn O. Pearce wrote:

> Hmm. n is unsigned and last_value is signed.  Uh?  I know you are
> using the special value -1 to mean we've never output anything for
> this progress meter but mixing signed and unsigned always gives me
> the willies.

Really?  ;-)


Nicolas
