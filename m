From: Ittay Dror <ittay.dror@gmail.com>
Subject: 'git format-patch' --interactive?
Date: Sun, 31 Aug 2008 07:27:09 +0300
Message-ID: <48BA1D9D.1070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 31 06:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZeYL-0007al-5F
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 06:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbYHaE1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 00:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbYHaE1U
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 00:27:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:13230 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbYHaE1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 00:27:20 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1469852ugf.37
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 21:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=enpGRkFGZz0fgSIB1Dqj2FM0tCycs925bnhv8XN5dDs=;
        b=l5nrdLlDJOUf0sjrPb4qqYa1K+35/jTajtO8fq+AJckd8OySyyjT+8hpyGQ6nYBxmP
         vOSUf1/uzxoN3TBU2lLoZX9A1Q3KrOZ9rldiU44hwZRM3PyJKtf/y176ea4hM15Nn542
         rxfHx+VKGMcCVj4XmElnMPtUPQANB9fNRmFs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=csLNm8uwXeNGJ8LJUQliuvXxM+updHVUiHshukfcswseFjZ4QkiS7ABdf1Jvqc1DO6
         ebwoKHzhgcWO5sRapdQHBotxQi9rG3Afzajmkfb+ZKVkSstPzXeH7j7IpxI4/a91tJ37
         MP8G3WySZBqPYvCqJz9gl8jDaf/Rj342OJ2DQ=
Received: by 10.66.244.11 with SMTP id r11mr1287446ugh.47.1220156837350;
        Sat, 30 Aug 2008 21:27:17 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id e33sm11037666ugd.52.2008.08.30.21.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 21:27:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94451>

Hi,

Is there a way (tool) to allow me to interactively format a patch so 
that I can remove formatting noise or insignificant changes?

Thank you,
Ittay

-- 
--
Ittay Dror <ittay.dror@gmail.com>
