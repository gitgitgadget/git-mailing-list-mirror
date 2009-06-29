From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: git in emacs
Date: Mon, 29 Jun 2009 21:50:12 +0200
Message-ID: <87prcmyg3v.fsf@wine.dyndns.org>
References: <f46c52560906250535k6a0eb0a5ne05dc327760d14bd@mail.gmail.com>
	<m3bpocxyf4.fsf@localhost.localdomain>
	<f46c52560906250613l3759375dk855632b255ddc6e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLNDD-0000Lw-8p
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 22:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZF2UML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 16:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZF2UML
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 16:12:11 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:58304 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZF2UMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 16:12:10 -0400
X-Greylist: delayed 1313 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2009 16:12:10 EDT
Received: from adsl-84-226-47-42.adslplus.ch ([84.226.47.42] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1MLMrm-0007Bd-9I; Mon, 29 Jun 2009 14:50:20 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 159381E78C5; Mon, 29 Jun 2009 21:50:12 +0200 (CEST)
In-Reply-To: <f46c52560906250613l3759375dk855632b255ddc6e8@mail.gmail.com>
	(Rustom Mody's message of "Thu, 25 Jun 2009 18:43:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.94 (gnu/linux)
X-Spam-Score: -3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122457>

Rustom Mody <rustompmody@gmail.com> writes:

> On Thu, Jun 25, 2009 at 6:29 PM, Jakub Narebski<jnareb@gmail.com> wrote:
>> This probably means that git.el (which version do you use) should
>> be corrected.
>
> Ok So I had an old version
> Now its version 1.0
> But I still get the same error :-(

The version number isn't helpful I'm afraid, they are all called 1.0...

You probably still have an old version, detached head support was added
quite some time ago. You can get the latest version from the git source
tree.

-- 
Alexandre Julliard
julliard@winehq.org
