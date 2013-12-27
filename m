From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 18:59:00 +0600
Message-ID: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 27 13:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwX0R-0005tP-QK
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 13:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab3L0M7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 07:59:03 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:41975 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab3L0M7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 07:59:01 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz11so4935812veb.32
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=OdHyzmVJ5yr/mdgyIz8+p5Khl18QzPJ5PQAFqNvL2/o=;
        b=EFNa2lgGr9lBNMweP1U12cXiYAwQLivorFe+C1s59v2XkQ5YRjBdXEABn59fsxIRlE
         AVbPxq9z7qMYNVjBxt19nLHgM8tlmBPY8y5vYC1lKGQH2Xz5p8ZL4wJWFJ9vRB0VZCaX
         gJzRnpF2YB8nfq5fqbaepKONyMgQyFB6NOvSEFJI4oK93fYHBkTTq1hLUrd7nQcQU/uG
         ixkHw6zeF859uLP/UiF1QGx+2twof8CJegHn49SfiB20zogHeTuCfE3V++pOQdtbWwGo
         b3UiwI9buDe+t1a2hF3YFBERrxDH/viYDW+aJ5qzG4JBhWR9EvwoCUSZmAksKID02lpt
         PV/g==
X-Received: by 10.58.39.66 with SMTP id n2mr1016758vek.81.1388149140636; Fri,
 27 Dec 2013 04:59:00 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 27 Dec 2013 04:59:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239723>

Hello everyone!

Quick question is, is it possible to use git:// protocol over
SSL/TLS/other secure transport?

Or the recommended way to do secure anonymous checkout is to simply
use https:// ?

Thanks in advance!

-- 
With best regards, Sergey Sharybin
