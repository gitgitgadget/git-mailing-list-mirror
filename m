From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 16:06:25 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601151606050.13999@tvnag.unkk.fr>
References: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Robert Labrie <robert.labrie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:06:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK5xX-0004GQ-HG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 16:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbcAOPGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 10:06:30 -0500
Received: from giant.haxx.se ([80.67.6.50]:32966 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754815AbcAOPG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 10:06:28 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.15.2/8.15.2/Debian-3) with ESMTPS id u0FF6PQo014115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Jan 2016 16:06:25 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id u0FF6P4W014111;
	Fri, 15 Jan 2016 16:06:25 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284174>

On Fri, 15 Jan 2016, Robert Labrie wrote:

> But it would be more awesome if git just supported schannel on Windows. I 
> think cURL does already.

curl does indeed support schannel.

-- 

  / daniel.haxx.se
