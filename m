From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 10:42:16 -0400
Message-ID: <19434.48712.225245.305483@winooski.ccs.neu.edu>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	<z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
	<19428.24021.324557.517627@winooski.ccs.neu.edu>
	<20100508044434.GC14998@coredump.intra.peff.net>
	<19428.62170.654092.308682@winooski.ccs.neu.edu>
	<20100508053025.GG14998@coredump.intra.peff.net>
	<7v39y3c5p1.fsf@alter.siamese.dyndns.org>
	<19429.3589.823244.270582@winooski.ccs.neu.edu>
	<20100512113855.GB23847@coredump.intra.peff.net>
	<19434.39095.448649.313537@winooski.ccs.neu.edu>
	<AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 16:42:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCD8j-0008ST-FT
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 16:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab0ELOmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 10:42:19 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:57115 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab0ELOmT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 10:42:19 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCD8a-0008Sl-7e; Wed, 12 May 2010 10:42:16 -0400
In-Reply-To: <AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146951>

On May 12, Bo Yang wrote:
> On Wed, May 12, 2010 at 8:01 PM, Eli Barzilay <eli@barzilay.org> wrote:
> > That would obviously be a better solution...
> 
> The new line level history browser utility will follow multiple line
> ranges of multiple files and it of course will do this. :) Please
> wait for some days, I will make it possible in this summer.

(Looking at the description (in the SoC2010Ideas page) it wasn't clear
to me whether this will be simple to use as log -- that is, just run
some `git foo dir/{x,y,z}' or `git foo dir'.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
