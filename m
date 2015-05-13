From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 0/3]
Date: Wed, 13 May 2015 14:23:51 -0400
Message-ID: <1431541434-21884-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 20:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsbKH-0001d4-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 20:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbbEMSYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 14:24:08 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36551 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbbEMSYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 14:24:07 -0400
Received: by pabsx10 with SMTP id sx10so58244458pab.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+TWNwGl5/H41Wf7WGoRfxtnMfCdh3xkrJzya+JjbJPk=;
        b=UZ15N5wpwTqe7X6JMfGmLUy8Yd4Y9f///xdmnq1jqGIZCioVbtGSzD2XWFeSTw9xVM
         03aDnD8XwRCFD5wY+kkcYOjZaqNrk4wQTgdqyDa2rvrJXCyxoyg0X77Z56ZMXmGwTvGQ
         k4gKDbKDOXUcOuRUi0uFcseFcV7t0IbQ+GRro4HPO091FsTnhUhJzx6jssvHT0MYi8jn
         XiRSLlE8XVqCXLFoJVUlbWD8Nyu2c10UTaM6XFIuWDIeCyaYFNeOCw1BX6AFpHP5V6fv
         yqmFe+iJFiWv3xYN76CKkpqj+Oe5p9vWmzP/YYoRcK0tV7X0lnKf+5wFMyA/e9BvzBrB
         QjVQ==
X-Gm-Message-State: ALoCoQn0N89oSK8r5PRgp0axfI6y70tqVYuW9/WAIdcCQae7LcJeewTWJ05jQMwu6SMCDqQeh9Fx
X-Received: by 10.68.198.36 with SMTP id iz4mr270845pbc.167.1431541446272;
        Wed, 13 May 2015 11:24:06 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.26])
        by mx.google.com with ESMTPSA id nt15sm20023104pdb.14.2015.05.13.11.24.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 11:24:05 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269000>

Oops, forgot to ammend commit before patch v8.  This patch *really*
includes the switch and type casting fixes.
