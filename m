From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Fri, 06 Nov 2009 09:25:33 +0100
Message-ID: <4AF3DD7D.4040102@viscovery.net>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com> <1257495059-12394-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:25:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6K8o-0006qy-0z
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbZKFIZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754523AbZKFIZb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:25:31 -0500
Received: from lilzmailmt02.liwest.at ([212.33.55.12]:5812 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754172AbZKFIZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:25:30 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N6K8U-0008CH-Aq; Fri, 06 Nov 2009 09:25:34 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E322A9F88; Fri,  6 Nov 2009 09:25:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1257495059-12394-1-git-send-email-ahaczewski@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132283>

Andrzej K. Haczewski schrieb:
> One more round of that patch with Nicolas' comments considered, and
> disclamer about the implementation added.
> 
> Johannes, can you replace previous commit with that patch?

Thanks; the result is in

  git://repo.or.cz/git/mingw/j6t.git pthreads-for-windows

-- Hannes
