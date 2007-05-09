From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 08:31:13 +0200
Message-ID: <20070509063113.GA10943@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site> <20070508213158.GB3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705090105450.4167@racer.site> <Pine.LNX.4.64.0705090015360.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 08:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlfi6-0006Hs-IS
	for gcvg-git@gmane.org; Wed, 09 May 2007 08:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967531AbXEIGbY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 May 2007 02:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967647AbXEIGbY
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 02:31:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4898 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967531AbXEIGbX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 02:31:23 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hlfhh-0002qg-00; Wed, 09 May 2007 07:31:13 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705090015360.18541@iabervon.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46667>

On 2007-05-09 00:54:03 -0400, Daniel Barkalow wrote:

> And "unsigned char *" or "unsigned char[20]" is always the octets;
> the hex is always "char *".

uint8_t, anyone? :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
