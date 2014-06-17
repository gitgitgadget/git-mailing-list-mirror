From: David Turner <dturner@twopensource.com>
Subject: (unknown)
Date: Tue, 17 Jun 2014 13:13:18 -0400
Message-ID: <1403025199-21360-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 19:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwwwy-0002R5-LA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933791AbaFQRNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:13:31 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:63306 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933325AbaFQRN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:13:29 -0400
Received: by mail-qc0-f177.google.com with SMTP id r5so6627079qcx.8
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 10:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=KZbce4s8LSdVNHXnPKmfYI+C7BxyUKy/JxFd6/hP6ws=;
        b=Mjy3TDTLV6wYTi9EnG7k31F9ZZkSDWWAzvjIV5ITCMxD2ZqktcyMO2JbRs1kmUeK5n
         6zrkdMLdf49u8t+DOiJhMbAlO/HwpKxKsjrWhhLPlr6kW+wQxBpZVA1rT+PEWpi1z1qg
         gwu/U1aCyc4Np4f2HQHG2zBRFD9Phzz8yQFbnTHt0X163erEhsztYAYX8+5bAUJn7HkS
         0vO59v95i2oM7eVB6i69Q6is9eqIVICQBdyuDRq3Zr5CeKHJPLZK/gZlaRb9veLIRecS
         ZvFW51sXe+JNsyxKUSPqEt5gMAE/ZG1TeKrlkB36xigix00N+ELXLS5jZ601F3O+keBF
         uiTw==
X-Gm-Message-State: ALoCoQnTBY1jMHQVkAXYNliYkkC/QiRd8I+ABsT0+aGd4BN3kQ/fLX5nTIhXPuS0Ops1GV7yejdP
X-Received: by 10.140.102.163 with SMTP id w32mr15935641qge.97.1403025208601;
        Tue, 17 Jun 2014 10:13:28 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id j9sm10913862qao.46.2014.06.17.10.13.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 10:13:25 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
Subject: 
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251923>


This version changes only the commit message; there is no longer any
configure.ac code.
