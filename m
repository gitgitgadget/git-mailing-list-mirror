From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bash completion with colour hints
Date: Thu, 27 Sep 2012 10:55:46 +0200
Message-ID: <50641492.3020204@drmicha.warpmail.net>
References: <50631885.8090604@nieuwland.nl> <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com> <506356AA.3050005@nieuwland.nl> <7vfw64rm6s.fsf@alter.siamese.dyndns.org> <5064140E.50007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Oosthoek <soosthoek@nieuwland.nl>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Sep 27 10:55:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH9t0-0006e2-4D
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 10:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2I0Izt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 04:55:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57119 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753216Ab2I0Izs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 04:55:48 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 69C4820A41;
	Thu, 27 Sep 2012 04:55:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 27 Sep 2012 04:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=DG60kaYVdWKJZYL1ZLGIf3
	dRoKU=; b=uQIqHkd5glTLqvDimRD1LfkEDEDAnF5oElMzCPPUtMJgkN+kbqKXzV
	t1ftbDZxw9FsPuemsWo1HvLMkSlZlBTIMDlDWgSxdnqUfKDj6DTJHjygARBPOxzq
	9ma4gfAKxmloon8al0pu/gfPAxBW3H4byscBofM/kelVprEy/CDd4=
X-Sasl-enc: y7i/Ol2xmRDj7sBBkGdRDI9WMOzjYoQAorM6GQtYGb0+ 1348736148
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9D45B482701;
	Thu, 27 Sep 2012 04:55:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5064140E.50007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206471>

Michael J Gruber venit, vidit, dixit 27.09.2012 10:53:
...and I just checked that gzipped attached patch. No, it doesn't work
that way at all.

Michael
