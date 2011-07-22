From: neubyr <neubyr@gmail.com>
Subject: tracking file locally without pushing it to remote
Date: Fri, 22 Jul 2011 14:23:33 -0500
Message-ID: <CALFxCvzqGBbq0fqtLJdwTideh9Un-cAEeQi8WpC496qoyCLg4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 21:23:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkLJz-0007eD-KC
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104Ab1GVTXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 15:23:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47673 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab1GVTXe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:23:34 -0400
Received: by gyh3 with SMTP id 3so1464431gyh.19
        for <git@vger.kernel.org>; Fri, 22 Jul 2011 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=sIBDYHSI85oZIDWcUAK+46fbBy7IUQM7Kmhrem1+w+w=;
        b=aQULACpWhlVYICFdr2eieBhNCy/x2dMgSS5U011X+9BzdhdONLKCn4TPrdjzeoz1mQ
         RXzniApepzrFzXTMgIOFEVjVWqryH1ECjxHZkbfeL46BoKJSJEv5yUM3TdAr4yTvk/33
         AXUaT1P2sU+ryGguZ33VltDnWjUBz4nKNseIA=
Received: by 10.236.46.74 with SMTP id q50mr2839117yhb.275.1311362613944; Fri,
 22 Jul 2011 12:23:33 -0700 (PDT)
Received: by 10.236.105.145 with HTTP; Fri, 22 Jul 2011 12:23:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177659>

I have two configuration files in a project which I would like to
track locally, however avoid pushing them to the remote repository. Is
it possible do that? Any suggestions on how can it be done?

--neu.by.r
