From: "Sigurdson, Dirk" <Dirk.Sigurdson@T-Mobile.com>
Subject: Determine Blob ID from Commit ID and File Path
Date: Thu, 25 Jun 2009 12:02:37 -0700
Message-ID: <C66917DD.29BF%dirk.sigurdson@t-mobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 25 21:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJuE4-00022A-Mm
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbZFYTDC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 15:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZFYTDB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 15:03:01 -0400
Received: from mail1.t-mobile.com ([206.29.162.141]:1301 "EHLO t-mobile.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751663AbZFYTDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 15:03:00 -0400
Received: from ([10.1.1.64])
	by nxprdapirn01.t-mobile.com with ESMTP  id 5502254.290310099;
	Thu, 25 Jun 2009 12:02:39 -0700
Received: from NXPRDMSHUB03.gsm1900.org ([10.133.32.112]) by waprdmsims04.t-mobile.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Jun 2009 12:02:38 -0700
Received: from NXPRDVSMBX17.gsm1900.org ([10.133.32.101]) by
 NXPRDMSHUB03.gsm1900.org ([10.133.32.112]) with mapi; Thu, 25 Jun 2009
 12:02:38 -0700
Thread-Topic: Determine Blob ID from Commit ID and File Path
Thread-Index: Acn1x4EZtcPGfIoUBkOviC0yscUSaw==
Accept-Language: en-US
Content-Language: en
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-tm-as-product-ver: SMEX-8.0.0.1285-5.600.1016-16724.004
x-tm-as-result: No--28.893500-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
X-OriginalArrivalTime: 25 Jun 2009 19:02:38.0942 (UTC) FILETIME=[8241D7E0:01C9F5C7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122235>

Given a commit id and the path to a file, I=B9d like to be able to dete=
rmine
the blob id for the file.  Is there a git command that would provide th=
is
info?
