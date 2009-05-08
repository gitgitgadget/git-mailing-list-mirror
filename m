From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I want "fast forward my workdir to upstream if it's safe"
Date: Fri, 08 May 2009 08:57:02 -0700
Message-ID: <7vk54rvb8x.fsf@alter.siamese.dyndns.org>
References: <86prekfv7z.fsf@blue.stonehenge.com>
	<20090508023028.GA1218@coredump.intra.peff.net>
	<F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Fri May 08 17:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2SRk-0007go-Mt
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 17:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbZEHP5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 11:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbZEHP5E
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 11:57:04 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33342 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbZEHP5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 11:57:03 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508155703.UZJO17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Fri, 8 May 2009 11:57:03 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id p3x21b0044aMwMQ043x2VH; Fri, 08 May 2009 11:57:02 -0400
X-Authority-Analysis: v=1.0 c=1 a=QCkDTQBM-eUA:10 a=Od5LeTB_ssUA:10
 a=ADGUV1-a64TrHUo3f6AA:9 a=4SdqE8GFSdDp53-3IBq69WpsPrcA:4
X-CM-Score: 0.00
In-Reply-To: <F871F2A1-DFCF-4642-BB53-7BE483A93271@orakel.ntnu.no> (Eyvind Bernhardsen's message of "Fri\, 8 May 2009 14\:34\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118613>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:

> I read it as a request for pull/merge --ff-only (based on "abort if
> the workdir is dirty or is not a fast-forward update").  This feature
> has been implemented twice, but never included:

Interesting.  Do you mean twice they were both found lacking, substandard,
useless, uninteresting, buggy, incorrect, or all of the above?  Or was it
just somebody simply forgot to apply a perfect patchset twice?
