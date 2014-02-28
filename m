From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: msysgit color scheme
Date: Fri, 28 Feb 2014 16:38:54 -0600
Message-ID: <CAHd499Arq_KhSKH=quez4irU_i4AjZN-anbvGn3XM--Cg4Nypg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 23:39:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJW56-0006oe-8R
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 23:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaB1Wi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 17:38:56 -0500
Received: from mail-ve0-f170.google.com ([209.85.128.170]:52638 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaB1Wiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 17:38:55 -0500
Received: by mail-ve0-f170.google.com with SMTP id pa12so1448397veb.29
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=zE4HHfTCw6G9cHOgH3J5CQTWItqFfm/qLlXSlrB08Qc=;
        b=HOQo7R+HwuvwSHSPEaP7IELis1n6Q1kVIP+vGmFd74nNRRcnHTaHhBVJqoJlmAEXUE
         f+KNk488sPnS7oGWhcqAi4xlHK9J6ZYaqLPOB1BwLgzLGnD3/rqJcyeyKo50mcM1wUMm
         YpUMxTKvO3GOPt0o8O5p45awC17st/7YfnIlyZA7uMsV1Y9Su0rHcYKP8ClpoiCiVL0H
         oqIigbHqd+kdhq15G1NIPtG6v7IS/3uqCe6py06PrFn1Qe8hT5Qlt4AzRb+4dOasuWbc
         1h7Ct+2/GEYTp31loOcxpza1qhiBZT2JnY1BK8v68gB4J8qbAT2yscfRFV/ecfqPFk7s
         o3AQ==
X-Received: by 10.58.186.132 with SMTP id fk4mr4671249vec.9.1393627134912;
 Fri, 28 Feb 2014 14:38:54 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.1.132 with HTTP; Fri, 28 Feb 2014 14:38:54 -0800 (PST)
X-Google-Sender-Auth: EGJ-0DzZuDZmVjFYVLv_viw1U8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243023>

Is there a way to change color scheme in msysgit without going through
the Properties >> Colors settings?

Reason I ask is because I share the same HOME directory and .bashrc
file between msysgit and cygwin, and it'd be nice to use the same
color scheme defined in the bashrc between both.

Any tips?
