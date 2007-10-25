From: Bo Yang <techrazy.yang@gmail.com>
Subject: Git and Windows
Date: Thu, 25 Oct 2007 20:12:07 +0800
Message-ID: <47208817.60804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 14:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il1Zd-0002wF-1a
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 14:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbXJYMMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbXJYMMK
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 08:12:10 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:7663 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbXJYMMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 08:12:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so451369rvb
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=X7VzVCJYzFuBUbIfj5T9S7McsxrnvVbOdjnmivMEXY0=;
        b=XbskJq3h7cFS+BEyWO0D0F6U256EGuJJOOYqm1AQg3NrGgLLIH7lGBxnaphxM2LlRGMuvLb+4RS4Br4B3/XpnsokFQUn/37iqGaaZCJ6aEu9RPl3ddlephppApJMF2lZahH6+bTx/nHzc3YbczyKk2ke5y6faPwFYo9Wp9bSgbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qBxblnISQRBFO6mcLH+gQRF2FUz4VlcITgD3pyxmkvtdOBIYaBVSh0dhn+c52ODeYztqA25mLoQ+6uVQh/i/JkPB/Mxa2EwCkd+tJMAQ+SkUL8gcEsHwrxqhsBp9kHskPTH8C3ZJvjYRw+6ws4TLhEamThYKT7G6c3GI43EM/uI=
Received: by 10.141.196.13 with SMTP id y13mr853528rvp.1193314329321;
        Thu, 25 Oct 2007 05:12:09 -0700 (PDT)
Received: from ?192.168.1.123? ( [123.57.144.24])
        by mx.google.com with ESMTPS id f42sm4039964rvb.2007.10.25.05.12.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Oct 2007 05:12:08 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62313>

Hi,
   I am a new comer to this list but I have used git for two week 
development control. I think it is a very cool tool, the only flaw is 
that I have not found Windows version of it. Does git just aim at Linux 
kernel development? Is there any plan or in the future to migrate it to 
windows?

Thanks!
Bo
