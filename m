From: "Juan Jose Comellas" <juanjo@comellas.org>
Subject: FastCGI support in gitweb
Date: Sat, 1 Mar 2008 19:34:45 -0200
Message-ID: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 22:35:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZMb-0005A7-TM
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756636AbYCAVes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYCAVes
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:34:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:54599 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYCAVes (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 16:34:48 -0500
Received: by wx-out-0506.google.com with SMTP id h31so5178438wxd.4
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 13:34:45 -0800 (PST)
Received: by 10.70.32.2 with SMTP id f2mr9540737wxf.63.1204407285325;
        Sat, 01 Mar 2008 13:34:45 -0800 (PST)
Received: by 10.70.111.13 with HTTP; Sat, 1 Mar 2008 13:34:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75704>

I've seen that the current version of Gitweb (1.5.4.2) does not
support FastCGI, and looking in Google I found that about a year ago a
patch was sent to the list adding this functionality to it. I couldn't
find any additional emails indicating why they weren't accepted. Is
there any plan to add FastCGI support to Gitweb?
