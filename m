From: Robert Watson <robert.oo.watson@gmail.com>
Subject: command to show diff of a commit
Date: Thu, 22 Sep 2005 10:58:32 +0100
Message-ID: <72499e3b05092202583f9a751d@mail.gmail.com>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Sep 22 12:00:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINqf-0006Pj-Ez
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 11:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVIVJ6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 05:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVIVJ6e
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 05:58:34 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:20269 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751458AbVIVJ6d convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 05:58:33 -0400
Received: by qproxy.gmail.com with SMTP id v40so38435qbe
        for <git@vger.kernel.org>; Thu, 22 Sep 2005 02:58:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g/RIjvUlfNsjks+VJAN9TjYgCbuqSWrNZIV4/fby46t/xVniCDU22Q3x5T4uOcoQsAF563RDpLN4fiwZDT0atIrY1X4Tey9eb0RWz+2XkWr9dy1PRPiPtbiJhRTyoafYM9meZecc02RECGO/QzJ08HYn0QWMgOWwEgXYJCA2LqM=
Received: by 10.64.204.19 with SMTP id b19mr158167qbg;
        Thu, 22 Sep 2005 02:58:32 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Thu, 22 Sep 2005 02:58:32 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9102>

Hi,

I am wondering what is the best way to show the change introduced by a
commit. In the other words, is there a better way to do this:

git-diff b163512d4eb36ee946908b682c7863658c5a8db4^
b163512d4eb36ee946908b682c7863658c5a8db4

Thanks.
Robertoo
