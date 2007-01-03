From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-branch: show detached HEAD
Date: Wed, 3 Jan 2007 08:37:02 +0100
Message-ID: <8c5c35580701022337y6719883eyd907b89d0d6f7217@mail.gmail.com>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	 <1167780131528-git-send-email-hjemli@gmail.com>
	 <7v1wmcr3nz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 08:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H20gw-000383-55
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 08:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbXACHhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 02:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbXACHhU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 02:37:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:32328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbXACHhF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 02:37:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so7603280nfa
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 23:37:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tfHGEFqKU0RetSqTuh9y3vMbyFRzHnj0ENxwmQPDZJ/TQQZCXcBx+faRlsY07MeHJNebYoGXTWSm5iaF9mqu3KBAUUs5hqu9QDd0+LYlup/2EFZnxavuJzojV/CCt6F/yTymfw0qqBwwnBuJZFar3h9eUBIXmJNHqFWQ2FOVHyk=
Received: by 10.82.116.15 with SMTP id o15mr622422buc.1167809822679;
        Tue, 02 Jan 2007 23:37:02 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 2 Jan 2007 23:37:02 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wmcr3nz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35849>

On 1/3/07, Junio C Hamano <junkio@cox.net> wrote:
> Can we have two patches, one for loop restructuring without
> detached HEAD support, and then another to add support for it?

Sure, I'll do it tonight

-- 
larsh
