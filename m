From: Rustom Mody <rustompmody@gmail.com>
Subject: compiling git on debian
Date: Tue, 16 Jun 2009 16:36:58 +0530
Message-ID: <f46c52560906160406t910f5f3v4040525531ad78c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 13:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGWVQ-0007Wa-Ik
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 13:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZFPLG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 07:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZFPLG5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 07:06:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:47995 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZFPLG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 07:06:57 -0400
Received: by wa-out-1112.google.com with SMTP id j5so897390wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=VVUs9GPQj2JXg6sZq1fgfZenN8j5ae3URQg+Ap0EJbM=;
        b=fyRydQBA9NDh3ctt/XPXFn34POjR3UqWTx0Hy57XcC6TUToXMqsLcN0Nffj0ORlxXI
         7FOgn+y3B4zUPvYlJ7PDkZebgI02ax0X7qEJZnznLoyJ1Yzc62hyeItsv6/X7q4mch/V
         GVqg4tI+9kkUdpfUT/7Szvf2ypDOfbk1gb42Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vWVW0vd3himXoRzlXgrUr+95rONqRs5imxL+/L+54wLvX2zvpD1XcSI0ZZ1OBh/udV
         kJulf+mS06ooQadQfClDIOZlatWyIpvFbbmx2BbqAYzJcwqq2fcDGVCTcpyoqLE/uAoH
         dJj9Ad6cBDYYLsYq+++edy+1kYiaJAmJEk3Dk=
Received: by 10.114.74.18 with SMTP id w18mr13319745waa.167.1245150418076; 
	Tue, 16 Jun 2009 04:06:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121670>

Im trying to compile git on debian etch and get a problem with
curl-config not found.
I gather curl-config is in a number of debian dev packages.

Can someone tell me which which package?
