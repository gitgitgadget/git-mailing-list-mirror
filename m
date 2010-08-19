From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/3] apply: handle traditional patches with space in filename
Date: Thu, 19 Aug 2010 21:56:08 +0200
Message-ID: <201008192156.08529.j6t@kdbg.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org> <201008142037.50833.j6t@kdbg.org> <20100819014516.GA7175@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 21:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBDu-0004RX-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 21:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0HST4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 15:56:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25662 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab0HST4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 15:56:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2E1F1CDF8F;
	Thu, 19 Aug 2010 21:56:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9B6EF19F5BF;
	Thu, 19 Aug 2010 21:56:08 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100819014516.GA7175@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153952>

On Donnerstag, 19. August 2010, Jonathan Nieder wrote:
> Patch 2 contains the funny-filenames tests.  Testing on Windows would
> be welcome.

The series passes the test suite on Windows.

-- Hannes
