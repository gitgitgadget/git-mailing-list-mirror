From: Geert Bosch <bosch@adacore.com>
Subject: Re: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Mon, 19 Oct 2009 16:08:39 -0400
Message-ID: <3A647965-01B7-4025-A708-C05D25A63A7D@adacore.com>
References: <20091019195456.GA11121@unpythonic.net>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 22:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzyhI-00085X-6c
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 22:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbZJSUTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 16:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbZJSUTF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 16:19:05 -0400
Received: from rock.gnat.com ([205.232.38.15]:33281 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757416AbZJSUTE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 16:19:04 -0400
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 16:19:04 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 420B52BACA2;
	Mon, 19 Oct 2009 16:08:41 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r7+X8Z3Fmi29; Mon, 19 Oct 2009 16:08:41 -0400 (EDT)
Received: from potomac.gnat.com (potomac.gnat.com [205.232.38.115])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id EEA052BAC23;
	Mon, 19 Oct 2009 16:08:39 -0400 (EDT)
In-Reply-To: <20091019195456.GA11121@unpythonic.net>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130734>


On Oct 19, 2009, at 15:54, Jeff Epler wrote:

> When applying less than a full hunk, it's still often desirable to  
> apply
> a number of consecutive lines.
>
> This change makes it possible to sweep out a range of lines in the  
> diff view
> with the left mouse button, then right click and "Stage Lines For  
> Commit".
>
> The selected lines may span multiple hunks.

Great! I've wished for this feature...

Thanks,
    -Geert
