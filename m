From: flebber <flebber.crue@gmail.com>
Subject: Re: Locating Git Clone
Date: Wed, 19 Jan 2011 02:28:00 -0800 (PST)
Message-ID: <1295432880513-5939039.post@n2.nabble.com>
References: <1295426139368-5938712.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 11:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfVGv-0001Ur-EK
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab1ASK2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:28:03 -0500
Received: from sam.nabble.com ([216.139.236.26]:35709 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab1ASK2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:28:01 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <flebber.crue@gmail.com>)
	id 1PfVGi-0003WI-Gt
	for git@vger.kernel.org; Wed, 19 Jan 2011 02:28:00 -0800
In-Reply-To: <1295426139368-5938712.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165258>


Thanks for the help.

Didn't realise at all I could navigate like a unix shell. All solved thanks.

renshaw@RENSHAWRESIDENC ~
$ ls
Application Data  IETldCache      PrintHood     Start Menu  dwhelper
Aptana Rubles     Local Settings  PrivacIE      Templates   grails-core
Cookies           My Documents    Recent        UserData    ntuser.dat.LOG
Favorites         NTUSER.DAT      SendTo        _viminfo    ntuser.ini
IECompatCache     NetHood         Settings.bin  desktop     workspace

renshaw@RENSHAWRESIDENC ~
$ mv grails "c:/grails-core"
mv: cannot stat `grails': No such file or directory

renshaw@RENSHAWRESIDENC ~
$ mv grails grails-core
mv: cannot stat `grails': No such file or directory

renshaw@RENSHAWRESIDENC ~
$ mv grails-core "c:/grails"
-- 
View this message in context: http://git.661346.n2.nabble.com/Locating-Git-Clone-tp5938712p5939039.html
Sent from the git mailing list archive at Nabble.com.
