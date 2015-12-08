From: Jamie Evans <jamie@pixelrebel.com>
Subject: GPG public keys
Date: Tue, 8 Dec 2015 11:10:48 -0800
Message-ID: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 20:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Nf3-00026V-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 20:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbbLHTKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 14:10:49 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:42559 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbLHTKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 14:10:49 -0500
Received: from homiemail-a6.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id F1A0389F8C
	for <git@vger.kernel.org>; Tue,  8 Dec 2015 11:10:48 -0800 (PST)
Received: from homiemail-a6.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id 79DA259807F
	for <git@vger.kernel.org>; Tue,  8 Dec 2015 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pixelrebel.com; h=from
	:content-type:content-transfer-encoding:subject:message-id:date
	:to:mime-version; s=pixelrebel.com; bh=gogVWpmBq2mtnOjIeCL2xjba7
	Js=; b=H+sIJupAIh4acv/SS/JW4KQip0rl7GgYyTieReLgw3KzZoYFywu+gz/xP
	oPLIyUPLmW7B8QxS0fUgL6D3H+PJK0H67ZDt2snt6EIbc96AhA/KKf62SdnMfnoa
	LLAbmFMgq4rIphEeTHYNzume1BI8gIZrsIpvXo2x/2Kg/3ZFyY=
Received: from [172.22.104.133] (unknown [209.151.228.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jamie@pixelrebel.com)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTPSA id 754CE598096
	for <git@vger.kernel.org>; Tue,  8 Dec 2015 11:10:48 -0800 (PST)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282172>

Hello,

Can you please point me to the public GPG keys used for source code signing?

Thanks,
Jamie
