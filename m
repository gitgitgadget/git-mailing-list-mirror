From: Michael Bergin <michaeljbergin@gmail.com>
Subject: Git Option/Subcommand Processing Library?
Date: Sat, 25 Jul 2009 12:28:12 -0400
Message-ID: <231BD892-07B1-452C-A224-047829E21991@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 18:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUk6k-0002VI-Iq
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 18:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZGYQ2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 12:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbZGYQ2T
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 12:28:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:15164 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZGYQ2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 12:28:19 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1222801qwh.37
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=xghBe1AD5sUtcgTpH9zzFBA+eYsqQ1CW0LctxDlMyuU=;
        b=L6CZkDak0WBJ7GidQUpRqsAFOO2zR0U35G8FmO0abDEvhWalplyHJMaqmo9o05mQD2
         +hbItL/ikWRRCCYpmBPRTsXqIsq+HFFbr17Y8CGcJFG1uOqpimzthD5YajimE08slGTw
         sbpObxUVS0XeZ0bAITBO/BDYO3o2EisJVl5FA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=Qe4PuuMm6ma6p0mpbnJ1AExqubMLaBsllv6cVhqf8QW+TBTkYLK/mn/fzThi3/lPxH
         bDaxzVoZeshRH/Ysez+ITenXDFkNdRF4hIfq3QtFDbA2CoCdGUFCJR4se19OyC7Vcai4
         p4f7NN0+6/a2/8fra5jMNWl/wrWs981QtdT7Q=
Received: by 10.224.67.16 with SMTP id p16mr4444578qai.180.1248539299053;
        Sat, 25 Jul 2009 09:28:19 -0700 (PDT)
Received: from mobile003.mycingular.net ([32.178.44.31])
        by mx.google.com with ESMTPS id 8sm5468954qwj.36.2009.07.25.09.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 09:28:18 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124019>

Is there a library containing just the option and subcommand  
processing code from git?  I saw a post about gitopt but can't find a  
project with that name.  If not is there any problem with me doing  
this?  Thanks.

- Mike Bergin
