From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Thu, 18 Oct 2007 10:34:37 +0200
Message-ID: <20071018083437.GA302@diana.vm.bytemark.co.uk>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org> <20071017021137.GO13801@spearce.org> <20071017082003.GA10799@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710171653500.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQqj-000104-Rm
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757665AbXJRIfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 04:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757407AbXJRIfO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:35:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2226 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbXJRIfM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:35:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IiQpx-00008B-00; Thu, 18 Oct 2007 09:34:37 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710171653500.19446@xanadu.home>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61506>

On 2007-10-17 16:56:09 -0400, Nicolas Pitre wrote:

> On Wed, 17 Oct 2007, Karl Hasselstr=F6m wrote:
>
> > Maybe an env variable could cause the code to emit
> > machine-friendly progress information instead?
>
> That won't help with remotely generated progress unaware of local
> env variable, and the remote server might still be generating old
> format.

Ah, I didn't realize the progress meter was generated on the remote
side. Sorry for the noise.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
