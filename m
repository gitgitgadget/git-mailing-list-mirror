From: Lea Wiemann <lewiemann@gmail.com>
Subject: git-show documentation
Date: Wed, 04 Jun 2008 02:50:13 +0200
Message-ID: <4845E6C5.8010000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 02:50:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3hCn-0001SQ-7J
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 02:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYFDAt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 20:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYFDAt2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 20:49:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:41324 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYFDAt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 20:49:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1181064fgg.17
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 17:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=+dPBrxMYOqfyaPwykYi8+BNf0vOxMJzxcbxxgKOPMo0=;
        b=LrxdNedp1dT4C2NI+aqkDS0kf1sSMExK3PeeTOXaj2XJRf7OPY8AJ1IF4y9e1EgqETa5wdn2OWmXAmzqSmP7aU/kSgyRYvsSgTF14ldR1EK/zt4WrbT85MxUt6SJKg75opoO6aoZgEPjRh/wB8UHK+ji25Idyw+g6kTp8ttOwYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=psDaQxEsA9P5GAM85YLy3zhLhnna2WatYToFfzaFTDeTA//5ROcNnJBaPyHHXJH+27T4YjEYvjsD7V5BYMDI0rYXSOCj/x3MGGxR9aIBfhNfv4C7nnZS/ruIOrDlZsea8ZYsnPxZxTiOVA4Gr8tN5xsY9YB/dF+cUm5cUa1J7ic=
Received: by 10.86.58.3 with SMTP id g3mr1700369fga.21.1212540566156;
        Tue, 03 Jun 2008 17:49:26 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.209.222])
        by mx.google.com with ESMTPS id e11sm800164fga.4.2008.06.03.17.49.24
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 17:49:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83738>

Just in case someone wants to fix it, man git-log lists a --header 
option (by including rev-list-options.txt), but it doesn't actually 
support this option.  Perhaps rev-list-options.txt should be 
copy-and-pasted instead of included so local changes can be made to 
git-log.txt.

-- Lea
