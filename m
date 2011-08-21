From: "Richard Tibbitt" <gitlist@lazyprune.com>
Subject: Re: Failure cloning from a separate-git-dir repository
Date: Sun, 21 Aug 2011 12:13:04 +0100
Message-ID: <upp157hv6v33nlfpsoeh68kqc7fvpdv7ig@4ax.com>
References: <6csv47te4qv41ni53q0kf1fne0a4e1grnm@4ax.com> <CACsJy8AavETJb-Lm0Qd6Sz54zYbgvDUWmf+uXYTxO3+iYNHvoA@mail.gmail.com> <p800579qgdoocnq388veh5gpjbu7r9ph52@4ax.com> <CACsJy8A4kvjn5Bgo6FtS+x4z=CRz8ctoDHh7D8XV3frOjDVfbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 21 13:13:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv5y1-0001Ag-1i
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 13:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab1HULNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 07:13:19 -0400
Received: from mail.workflow24.co.uk ([78.136.40.51]:6479 "EHLO
	mail.workflow24.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab1HULNS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 07:13:18 -0400
Received: from 82.152.159.100 [82.152.159.100] by mail.workflow24.co.uk with SMTP;
   Sun, 21 Aug 2011 12:13:09 +0100
In-Reply-To: <CACsJy8A4kvjn5Bgo6FtS+x4z=CRz8ctoDHh7D8XV3frOjDVfbw@mail.gmail.com>
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179801>

On Sun, 21 Aug 2011 10:27:44 +0700, Nguyen Thai Ngoc Duy wrote:

>Yes. Try "call git clone repo2git/.git clone2" (forward slash). The
>forward slash is hard coded some places in git-clone. I just want to
>make sure you dont hit another problem.

Thanks for that - same result sadly.

I'll see what the guys on the msysgit list say about it.

Richard
