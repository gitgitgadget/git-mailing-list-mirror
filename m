From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7701-repack-unpack-unreachable.sh: check timestamp of
 unpacked objects
Date: Mon, 19 May 2008 16:48:48 -0500
Message-ID: <muwFetVdZVj0u7hdn3wbFF5mvUXeSbjeC5MyMipJMopcTE4BPs_RBQ@cipher.nrlssc.navy.mil>
References: <16342222.1211083116270.JavaMail.teamon@b306.teamon.com> <7vd4niaozy.fsf@gitster.siamese.dyndns.org> <OleexvYZfiSxUgrxHbDqLpGl2g7TsoOO7pwZXC1fiyL2KxKVuWLtWw@cipher.nrlssc.navy.mil> <E8K6ZsektNV-bzzpBDDSjLUNAu6_Tgxq9EV2896g2zCI6VyLsESxXw@cipher.nrlssc.navy.mil> <20080519210843.GA25293@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 23:50:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyDFh-0007mK-1n
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 23:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760474AbYESVtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 17:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbYESVtt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 17:49:49 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57145 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399AbYESVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 17:49:49 -0400
Received: by mail.nrlssc.navy.mil id m4JLmm8Y016805; Mon, 19 May 2008 16:48:49 -0500
In-Reply-To: <20080519210843.GA25293@sigill.intra.peff.net>
X-OriginalArrivalTime: 19 May 2008 21:48:49.0005 (UTC) FILETIME=[1ED139D0:01C8B9FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82453>

Jeff King wrote:
> On Mon, May 19, 2008 at 03:27:02PM -0500, Brandon Casey wrote:
> 
>> Also, do you have a url to your posix reference?
> 
> I generally use:
> 
>   http://www.opengroup.org/onlinepubs/009695399/

That's what I was looking for (didn't look hard enough).

> Specifically:
> 
>   http://www.opengroup.org/onlinepubs/009695399/utilities/test.html

This should be more accurate than my old reference: 'man test' :)

thanks,
-brandon
