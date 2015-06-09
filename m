From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: gitscm vs. git-scm
Date: Tue, 09 Jun 2015 14:58:38 +0200
Message-ID: <5576E2FE.4090105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:58:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2J7A-0008D3-4b
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbbFIM6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:58:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47394 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbbFIM6n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 08:58:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4E9B3212B6
	for <git@vger.kernel.org>; Tue,  9 Jun 2015 08:58:42 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 09 Jun 2015 08:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=uH7
	pP8gTzdatvXBQNG5cWtD1SlY=; b=k8UXvNjD9vVasMX0o1M0/MZllBHMX2SICgZ
	eHz2jBvcA67o4N5A7U9V26YXHgafdndOh4JkMBwNaTCb4jzA7fJh+bfT9Z4FcRRJ
	pLhIU8xqZ4qJU1wuc8N+ksRbBjuuXVcwbGPI6XqiBBVAGUF8Qb0eUdvqC8HD+L2f
	jYOCl10I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=uH7pP8gTzdatvXBQNG5cWtD1SlY=; b=Wm5ci
	00amzBLCS/UL248ZXk/qvoFQCZLRpuj1QLIc3D7vjAS/Grr2CPnud/yuC3nYaOs7
	HFtOJQp/or5Ovb693QdQmFN4SRn83E7scLsoVzYCsKCJRyihmcSL6LJImgPtLg+V
	p7EFi5NKh1r6YxN25GPSPJH5NOsp2VZYkhGBJY=
X-Sasl-enc: TFcTY1JESr/3lUx8LuIIn3+vQB0c/MzEqepCnsWxe2cQ 1433854721
Received: from localhost.localdomain (unknown [130.75.236.42])
	by mail.messagingengine.com (Postfix) with ESMTPA id D50E6C0001F;
	Tue,  9 Jun 2015 08:58:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271174>

Hi there,

I (mis-) remembered the git site address and noticed that gitscm.com
returns empty while git-scm.com is our beloved home. I thought, though,
that we have a couple domains with redirects but I may be misremembering
that also. Or DNS is "hicking up".

Cheers,
Michael
