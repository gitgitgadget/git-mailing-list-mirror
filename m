From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Mon, 19 Mar 2007 11:52:05 +0000
Message-ID: <200703191152.07686.andyparkins@gmail.com>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com> <Pine.LNX.4.63.0703190120270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	F <ff.pptux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 12:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTGPd-0002gq-1K
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 12:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbXCSLwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbXCSLwR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 07:52:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:24106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbXCSLwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 07:52:16 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1294910uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 04:52:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RpXU2RCynjHA9iD/5juGI/aWVHQG4PlCewLr/ZeAIvCSLQPgjY3enos7zA2mYiPlt/3iGTP9mKosuUQZ2fcz5VYUsJe4WJ9tUgTIIsI4PIx6f2JmtNk82srpxxOBUiuuL1xQZ4192MXIdSxaAY74ZdgMYo7PSYQK7gXsv08Dn0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HPezbXciKpyyQIgbyQSNxxXMn5f4NRJHxxM60wwcBHLJo/WECOqNnyohsZ/rK84/ggVfvoDZ5rEgLzfxIQSY6nOjQmD4Mu0aBYE4XahXgl30wL+U42R4OoaCHDV+/Hn1Sq5+gISz3mksUKuQaBxDtHJo/8laXodNTVWcrpy06fU=
Received: by 10.65.243.18 with SMTP id v18mr7417600qbr.1174305134025;
        Mon, 19 Mar 2007 04:52:14 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id r33sm13791796nfc.2007.03.19.04.52.12;
        Mon, 19 Mar 2007 04:52:13 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0703190120270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42606>

On Monday 2007 March 19 01:31, Johannes Schindelin wrote:

> Okay, I'll have a try at a short HOWTO find out how things are organized
> in Git's source code.

That was fabulous.  I learnt some very interesting things.

Can I suggest that this should be a wiki page or even 
Documentation/developer-tutorial.txt?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
