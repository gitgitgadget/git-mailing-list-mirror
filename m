From: Ondrej Oprala <ooprala@redhat.com>
Subject: gitk's truncated tags
Date: Tue, 27 May 2014 14:12:55 +0200
Message-ID: <53848147.1090604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 14:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpGFm-0003vH-2u
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 14:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbaE0MNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 08:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64574 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbaE0MNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 08:13:08 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s4RCD8tm028135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 27 May 2014 08:13:08 -0400
Received: from [10.34.4.199] (unused-4-199.brq.redhat.com [10.34.4.199])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s4RCD7sp020488
	for <git@vger.kernel.org>; Tue, 27 May 2014 08:13:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250164>

Hi, is there any way to display full tag names in gitk,
for tag names longer than 16 characters? The way 1.8.x did things?

Thanks,
Ondrej
