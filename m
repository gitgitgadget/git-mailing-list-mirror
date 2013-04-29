From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] [RESEND] Minor additions to git-completion.bash
Date: Mon, 29 Apr 2013 18:20:33 +0530
Message-ID: <CALkWK0koi9UwN9uRUci3ictpMy_T5TMey_t9fNNM4HpBvqEG0A@mail.gmail.com>
References: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 14:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWnY7-0004ui-3f
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 14:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166Ab3D2MvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 08:51:15 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:55585 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab3D2MvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 08:51:14 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so7333842iec.28
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 05:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oj0G0gNcACAJz0SOayV+j+Po/YSTWU+EvwZBQlixp5k=;
        b=GnLv/Z3wR5X2p8KP7LGG18zmtcg5NfMFjv55pv1N8ukgfJeicjKjCuYQUcdicP+NNd
         Y0chZey6M2cxY6YjevuHhzph6kARYXvI/eevtTdLL45rScFCUrrjd/Lf4Cmnh+zwFStA
         ldiy/mFDK0osXrqdz/g9F5nEu1vGV5fUlLa7j4IKfgI+KIaHadrQOWN6amlMPqB67YOE
         AkoOAR2Az3nbKZq/aGtQHxK7MKQEUo2tbNthY2CDuv4R7AW90QG/8XkXLbxkX5Rpe8iX
         dLUeTF6cLPYHMQ+wQpWgHobZmbuAEfX+mxF7wNBiy9MR1RfqKJaN0jlGE2ArXWqbcJBX
         eIoQ==
X-Received: by 10.50.3.38 with SMTP id 6mr728009igz.44.1367239874093; Mon, 29
 Apr 2013 05:51:14 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 05:50:33 -0700 (PDT)
In-Reply-To: <1367239781-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222791>

[Corrected Felipe's email id; sorry, I'm having a bad day]

Ramkumar Ramachandra wrote:
> [...]
