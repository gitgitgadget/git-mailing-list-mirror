From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Mon, 26 Nov 2012 00:07:20 -0800
Message-ID: <50b31528.daN7oo8Yh6Jzvx5V%perryh@pluto.rain.com>
References: <20121126053557.E56434065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 09:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcu1d-0006FW-W5
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 09:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab2KZI0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 03:26:30 -0500
Received: from agora.rdrop.com ([199.26.172.34]:2993 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2KZI0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 03:26:30 -0500
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Nov 2012 03:26:30 EST
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id qAQ8Bp3n014960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Nov 2012 00:11:51 -0800 (PST)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id qAQ8BoWD014959;
	Mon, 26 Nov 2012 00:11:51 -0800 (PST)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA00306; Mon, 26 Nov 12 00:07:18 PST
In-Reply-To: <20121126053557.E56434065F@snark.thyrsus.com>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210424>

esr@thyrsus.com (Eric S. Raymond) wrote:

> This document contains no new policies or proposals; it attempts
> to document established practices and interface requirements.
...
> +4. If your command has any dependency on a a particular version of
                                            ^^^

typo.  (granted this is an extreme nit)
