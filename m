From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v5 1/6] pull: rename pull.rename to pull.mode
Date: Tue, 29 Apr 2014 05:24:32 -0700 (PDT)
Message-ID: <1398774271999-7609129.post@n2.nabble.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com> <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 14:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf769-0007Sh-Az
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 14:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934024AbaD2MZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 08:25:14 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:51915
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbaD2MZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 08:25:13 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf75b-0001Ay-0b
	for git@vger.kernel.org; Tue, 29 Apr 2014 05:24:47 -0700
In-Reply-To: <1398770226-9686-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247578>

Felipe Contreras wrote
> [PATCH v5 1/6] pull: rename pull.rename to pull.mode

s/pull.rename/pull.rebase/



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-v5-0-6-Reject-non-ff-pulls-by-default-tp7609118p7609129.html
Sent from the git mailing list archive at Nabble.com.
