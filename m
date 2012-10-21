From: Mike Norman <mknorman@gmail.com>
Subject: Links broken in ref docs.
Date: Sun, 21 Oct 2012 00:31:13 -0700
Message-ID: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 09:31:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPq0M-000898-8l
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 09:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab2JUHbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 03:31:15 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59326 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab2JUHbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 03:31:14 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1591318oag.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YRphB/ywMMmW6kt/T3aqiDwsffaRSO5nHKRuLKfyWxw=;
        b=0Yi4U3AjisKxW1Rtb/Kf2r5/0QCDtDFn/oLezz3PZUz9frK+bU6A8xjytaSyiIJrWB
         WSnuj6ecnWFdB6ihn/ysm0sEA1MC76D4tZ3Y3rtECZSTiqxqTmWJAHGug/om9Cel4LfN
         /jlH7Xto5rhigJItrcpX6nUTDLjlAl/HXScPBannNok/nmHMYQ4N0SRaBNKDF7JalsRB
         UN73Mi/+HohozUN/IBagjmSbTw41BzFAdyC3qKtNUIZMUrQWKGo/yGwDlRsB/Xl9WuFB
         V1Zo283ih9VkE/ybbMLsW+/1HsrSAAnam8OPFUdabenV2Sf8sERhYIW05Qhs76v/GvnD
         +DZg==
Received: by 10.60.30.100 with SMTP id r4mr5411485oeh.121.1350804673837; Sun,
 21 Oct 2012 00:31:13 -0700 (PDT)
Received: by 10.76.76.202 with HTTP; Sun, 21 Oct 2012 00:31:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208116>

Many links on scm-git.org/docs simply reload the page.

For example, all of Sharing and Updating section simply reload the
docs page. And tons others. Must be a broken link or routing problem.
Repros on FF 14.0.1 and Chrome. Good luck!

IRC was useless.

Also, fuck your stupid email policies. :)
