From: Benedikt Andreas Koeppel <bkoeppel@ee.ethz.ch>
Subject: Re: Modified files directly after clone
Date: Wed, 10 Mar 2010 07:47:24 +0100
Message-ID: <18121BB2-A8BE-411F-9CF0-EDDD12B31CB3@ee.ethz.ch>
References: <7416BCB6-306F-4BC1-913C-1208746DA93E@ee.ethz.ch> <905315641003091359q4f7cd533o698ec507b9805e36@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 07:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpFhf-0005DR-RA
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 07:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab0CJGr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 01:47:27 -0500
Received: from smtp.ee.ethz.ch ([129.132.2.219]:41713 "EHLO smtp.ee.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab0CJGr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 01:47:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 7018CD93AB;
	Wed, 10 Mar 2010 07:47:25 +0100 (MET)
X-Virus-Scanned: by amavisd-new on smtp.ee.ethz.ch
Received: from smtp.ee.ethz.ch ([127.0.0.1])
	by localhost (.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3zEArCdZhURa; Wed, 10 Mar 2010 07:47:25 +0100 (MET)
Received: from [192.168.2.105] (84-75-183-84.dclient.hispeed.ch [84.75.183.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: bkoeppel)
	by smtp.ee.ethz.ch (Postfix) with ESMTPSA id 256B7D937B;
	Wed, 10 Mar 2010 07:47:25 +0100 (MET)
In-Reply-To: <905315641003091359q4f7cd533o698ec507b9805e36@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Am 09.03.2010 um 22:59 schrieb Tarmigan:
> By default HFS+ filesystems on OSX are case insensitive so you see
> problems like you described with the linux kernel source which has
> different files named xt_TCPMSS.c and xt_tcpmss.c.

thank you very much for the explanation. Unfortunately, some software (namely Adobe CS2) does not work properly with HFS+ with case sensitivity. I'll need to get a Linux PC for coding :-).

OK, Problem solved. Thanks.
Benedikt