From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: "info/exclude" vs bare repo
Date: Sun, 22 Apr 2007 11:56:21 -0400
Message-ID: <f36b08ee0704220856iffe5c92n75c522589b4c838d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 17:56:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfeQM-0006kr-4I
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 17:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbXDVP4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 11:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbXDVP4X
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 11:56:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:9904 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161205AbXDVP4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 11:56:22 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1513397wxd
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 08:56:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Rps3LryYNGpWru1PbCasYFo9/u1ZswRGn8RYaLQ66A3peYmSoUKxtoLkgjE1eQtBKczaFhsInjAoEcz8tqY86z1RRjcMaqyj5OCV6JHikm+TbhvX41je4yQ/E9YKnSB5EROVQDv05HvlVIaDqTQLVIkwoH8F5InNHR9t35fcA/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pPQNgSgSb4J56/lcUGiPRRXXF+neIZ8KK8bHbLEJotx5RRz/5sSwY3kGo8HOEGbFg1P7greJUkt2sqDZU32PwmysBLgtD1VyPcMxSN8pKLC8RmzR+UF/ipul8pAozFJ6MXJTnU/7P9I5Or+AMaBcJ4dJNrF16SOdU2Z0LLkAmvM=
Received: by 10.90.83.14 with SMTP id g14mr1439549agb.1177257381948;
        Sun, 22 Apr 2007 08:56:21 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Sun, 22 Apr 2007 08:56:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45245>

File "info/exclude" has no meaning/effect in the bare repo, correct ?

Thanks
Yakov
