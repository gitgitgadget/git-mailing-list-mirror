From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 15:21:44 +0900
Message-ID: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 27 07:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwtqA-000823-Sm
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 07:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXK0GWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 01:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbXK0GWQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 01:22:16 -0500
Received: from mi0.bluebottle.com ([206.188.25.15]:50441 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbXK0GWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 01:22:16 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lAR6MFXQ010010
	for <git@vger.kernel.org>; Mon, 26 Nov 2007 22:22:15 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=DooURqbFWfIyQ3ek/Ac0GV66fslAU6AS/EkwAxSr2Lm6eS9QgAL6O9/lmVo4TftoX
	wvBf5gdhceMu9R9yx6+lJZkBjhXJ90klcsNLjetFR2/9hdI7oQ/Opq80JR6yKPU
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lAR6LusV024649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2007 22:22:06 -0800
X-Trusted-Delivery: <7b0c75e38dd9fb89e94e0d3fe233575b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66170>

Quoting Andreas Ericsson <ae@op5.se>:

> "git pull --rebase" already has an implementation. Dscho cooked one up
> which I've been using since then. It works nicely.

What is the reason that the option was not added to the official git?  Was it coded poorly, buggy or were there some other issues?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Find out how you can get spam free email.
http://www.bluebottle.com/tag/3
