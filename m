From: Sergey Yanovich <ynvich@gmail.com>
Subject: git tool to keep a subversion mirror
Date: Tue, 19 Jun 2007 09:50:55 +0300
Message-ID: <11822358554129-git-send-email-ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, J.Sixt@eudaptics.com
X-From: git-owner@vger.kernel.org Tue Jun 19 08:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0XXG-0004hF-UR
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 08:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754719AbXFSGtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 02:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbXFSGtx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 02:49:53 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:61292 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbXFSGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 02:49:53 -0400
Received: by hu-out-0506.google.com with SMTP id 19so874277hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 23:49:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bhPLKimG6GhCjvm+vw6AqtgEPjE8+/4I4smpVt+yzlMipm1uOwqv+HTICm3JBtpfiXV9tXW0skgnCijkyFMUZWwmuXSQVdXqrlmytEyeps9k12d8zQrD8vgBizb71Mt8WwueJ0u/iQo2n9xb0kKNoOBAdR85LqLdwMx0TTcfluk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NkEm8kko4tHwgqzCGp3C7LLofXDsi3IQrz6EN28jT4ycUC7HHcmgConvMcbSuFmNzSV0rEq79qoJpcaHvgK/iEXo3IBBeDeQgfknHXWBJpUKde4iUxJno8XyYGr4+JRsBnFEy9s3Qdso6VIuClEA1gGTugPOpKfgPEoNJnxxCwg=
Received: by 10.78.165.16 with SMTP id n16mr2652904hue.1182235791648;
        Mon, 18 Jun 2007 23:49:51 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id 2sm2382679hue.2007.06.18.23.49.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 23:49:51 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0XYF-0003T7-95; Tue, 19 Jun 2007 09:50:55 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: 11821688443683-git-send-email-ynvich@gmail.com
References: 11821688443683-git-send-email-ynvich@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50445>

A set of patches updated with comments from this list follows.

Thanks for your time.
