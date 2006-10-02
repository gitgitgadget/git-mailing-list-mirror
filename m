From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Stop making git-merge-recur
Date: Sun, 01 Oct 2006 19:49:43 -0700
Message-ID: <45207E47.8080107@gmail.com>
References: <45207D32.8040300@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 04:49:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUDsN-0002Vd-N6
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 04:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWJBCts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 22:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWJBCts
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 22:49:48 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:51491 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750865AbWJBCts (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 22:49:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so2283921pyg
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 19:49:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=utqmpvuVAHdTfqZjWDLcCyNIHV7Ot+SWXxCQxBDt03C7oUAWMQE2xcErXHn8g86FIK8iMWfjBQF1LIgazjbfiZzE8pdmKHp4REz0dwhEGL7HENzShHT4zihtdJ42gJFcW2bw8ytYRyUw9T7fP/qEW+FN0r5+xMtk2lXcdYDdPFQ=
Received: by 10.65.232.18 with SMTP id j18mr6475593qbr;
        Sun, 01 Oct 2006 19:49:47 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.gmail.com with ESMTP id f18sm4187108qba.2006.10.01.19.49.45;
        Sun, 01 Oct 2006 19:49:46 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <45207D32.8040300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28212>

A Large Angry SCM wrote:
> Git-merge-recur is no longer installed and make clean no longer
> removes it, so creating making it.
              ^^^^^^^^^^^^^^^^^^
Should be "so stop creating" it.
